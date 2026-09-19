#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [[ "${RUBBLE_SCRIPT_MANAGED:-}" != 1 ]]; then
  exec "${RUBBLE_EXECUTABLE:-rubble}" script --inherit-env --language bash "${BASH_SOURCE[0]}" "$@"
fi

script_dir="$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" && builtin pwd)"
publication_relative='publish-runtime.sh'
source "${script_dir}/${publication_relative}"
jenkins_pipeline_path='rubble-generated/Jenkinsfile'
pipeline_mode=webhook
configured_pipeline_name='jenkins-builder-generated-pipelines'
auth_key_parameter='RUBBLE_PIPELINE_AUTH_KEY'
job_parameters_relative='jenkins-job-parameters.mjs'
webhook_build_relative='jenkins-webhook-build.mjs'
root_hash="${root_id%%-*}"
root_short="${root_hash:0:7}-${root_name}"

tmp_dir=""
curl_config_file=""
crumb_request_field=""
crumb_value=""
crumb_loaded=false
pipeline_name=""
encoded_job_path=""
encoded_job_parent_path=""
encoded_job_leaf_name=""
repo_url=""
branch=""
branch_spec=""
pipeline_path=""
payload_prefix=""
payload_prefix_was_set=false
pipeline_name_override="${configured_pipeline_name}"
queue_url=""
build_number=""
build_result=""
console_log_file=""
pipeline_definition_prepared=false
job_trigger_requires_parameters=false

rubble_mktemp() {  mktemp "$@"; }
rubble_sed() { sed "$@"; }
rubble_awk() { awk "$@"; }
rubble_tail() {  tail "$@"; }
rubble_tr() {  tr "$@"; }
rubble_date() { date "$@"; }
rubble_rm() { rm "$@"; }
rubble_cat() { cat "$@"; }
rubble_curl() { curl "$@"; }
rubble_sleep() {  sleep "$@"; }
rubble_chmod() { chmod "$@"; }
rubble_dirname() { dirname "$@"; }

log() {
  printf '[jenkins-publish] %s\n' "$1" >&2
}

fail() {
  log "ERROR: $1"
  exit 1
}

cleanup() {
  if [[ -n "${tmp_dir}" && -d "${tmp_dir}" ]]; then
    rubble_rm -rf "${tmp_dir}"
  fi
}

trap cleanup EXIT

ensure_tmp_dir() {
  if [[ -z "${tmp_dir}" ]]; then
    tmp_dir="$(rubble_mktemp -d "${TMPDIR:-/tmp}/rubble-jenkins-publish.XXXXXX")"
  fi
}

trim_file() {
  rubble_tr -d '\r\n' <"$1" | rubble_sed 's/^[[:space:]]*//; s/[[:space:]]*$//'
}

require_positive_integer() {
  local name="$1"
  local value="$2"

  case "${value}" in
    ''|*[!0-9]*)
      fail "${name} must be a positive integer, got '${value}'"
      ;;
    0)
      fail "${name} must be >= 1"
      ;;
  esac
}

url_encode() {
  local value="$1"
  local encoded=""
  local ch
  local ord
  local i
  local LC_CTYPE=C

  # Percent-encode bytes. With UTF-8 input this produces standard UTF-8
  # percent-encoding; current callers pass sanitized ASCII job names.
  for ((i = 0; i < ${#value}; i++)); do
    ch="${value:i:1}"
    case "${ch}" in
      [A-Za-z0-9._~-])
        encoded+="${ch}"
        ;;
      *)
        printf -v ord '%02X' "'${ch}"
        encoded+="%${ord}"
        ;;
    esac
  done

  printf '%s' "${encoded}"
}

xml_escape() {
  printf '%s' "$1" | rubble_sed \
    -e 's/&/\&amp;/g' \
    -e 's/</\&lt;/g' \
    -e 's/>/\&gt;/g' \
    -e "s/'/\&apos;/g" \
    -e 's/"/\&quot;/g'
}

json_string_key() {
  local key="$1"
  local file="$2"

  rubble_tr -d '\n' <"$file" | rubble_sed -n "s/.*\"$key\"[[:space:]]*:[[:space:]]*\"\\([^\"]*\\)\".*/\\1/p"
}

json_bool_key() {
  local key="$1"
  local file="$2"

  rubble_tr -d '\n' <"$file" | rubble_sed -n "s/.*\"$key\"[[:space:]]*:[[:space:]]*\\(true\\|false\\).*/\\1/p"
}

queue_build_number() {
  local file="$1"

  rubble_tr -d '\n' <"$file" | rubble_sed -n 's/.*"executable"[^{]*{[^}]*"number"[[:space:]]*:[[:space:]]*\([0-9][0-9]*\).*/\1/p'
}

queue_cancelled() {
  local file="$1"

  json_bool_key cancelled "$file"
}

curl_config_escape() {
  printf '%s' "$1" | rubble_sed -e 's/\\/\\\\/g' -e 's/"/\\"/g'
}

write_curl_config() {
  local escaped_user
  local escaped_token

  ensure_tmp_dir
  curl_config_file="${tmp_dir}/curl.config"
  escaped_user="$(curl_config_escape "${jenkins_user}")"
  escaped_token="$(curl_config_escape "${api_token}")"
  rubble_cat >"${curl_config_file}" <<EOF
user = "${escaped_user}:${escaped_token}"
EOF
  rubble_chmod 0600 "${curl_config_file}"
}

curl_status() {
  local output_file="$1"
  shift
  local options=()
  if [[ "${pipeline_mode}" == webhook ]]; then
    options=(--connect-timeout 5 --max-time 15)
  fi
  rubble_curl -sS --config "${curl_config_file}" "${options[@]}" -o "$output_file" -w '%{http_code}' "$@"
}

sanitize_name() {
  local value="$1"
  local sanitized

  sanitized="$(printf '%s' "$value" | rubble_sed -e 's/[^A-Za-z0-9._-]/-/g' -e 's/--*/-/g' -e 's/^-//' -e 's/-$//')"
  if [[ -z "${sanitized}" ]]; then
    fail "cannot derive a non-empty Jenkins job name from '${value}'"
  fi
  printf '%s' "${sanitized}"
}

default_pipeline_name() {
  local timestamp="$1"
  if [[ -n "${configured_pipeline_name}" ]]; then
    printf '%s' "${configured_pipeline_name}"
    return
  fi

  sanitize_name "rubble-${timestamp}-${root_hash:0:7}"
}

reject_control_chars() {
  local value="$1"
  local label="$2"
  local i
  local ch
  local ord
  local LC_CTYPE=C

  for ((i = 0; i < ${#value}; i++)); do
    ch="${value:i:1}"
    printf -v ord '%d' "'${ch}"
    if (( ord < 32 || ord == 127 )); then
      fail "${label} must not contain control characters"
    fi
  done
}

validate_repo_relative_path() {
  local value="$1"
  local label="$2"
  local allow_empty="$3"
  local segment
  local old_ifs

  if [[ -z "${value}" ]]; then
    if [[ "${allow_empty}" == "true" ]]; then
      return 0
    fi
    fail "${label} must not be empty"
  fi

  if [[ "${value}" == /* || "${value}" =~ ^[A-Za-z]: ]]; then
    fail "${label} must be a repository-relative path, got '${value}'"
  fi
  if [[ "${value}" == *\\* ]]; then
    fail "${label} must use '/' separators, got '${value}'"
  fi

  reject_control_chars "${value}" "${label}"

  old_ifs="${IFS}"
  IFS='/'
  read -r -a segments <<<"${value}"
  IFS="${old_ifs}"
  for segment in "${segments[@]}"; do
    case "${segment}" in
      ''|.|..)
        fail "${label} must not contain empty, '.', or '..' path segments"
        ;;
    esac
  done
}

validate_branch_name() {
  local value="$1"
  local segment
  local old_ifs
  local LC_CTYPE=C

  if [[ -z "${value}" ]]; then
    fail "--branch must not be empty"
  fi
  if [[ "${value}" == -* ]]; then
    fail "--branch must not start with '-'"
  fi
  if [[ "${value}" == *\\* ]]; then
    fail "--branch must not contain backslash"
  fi
  if [[ "${value}" == *[[:space:]]* ]]; then
    fail "--branch must not contain whitespace"
  fi
  case "${value}" in
    *~*|*^*|*:*|*'?'*|*'*'*|*'['*)
      fail "--branch must not contain Git ref wildcard or special characters"
      ;;
  esac
  if [[ "${value}" == *..* ]]; then
    fail "--branch must not contain '..'"
  fi
  if [[ "${value}" == *@\{* ]]; then
    fail "--branch must not contain '@{'"
  fi
  if [[ "${value}" == *//* ]]; then
    fail "--branch must not contain empty path segments"
  fi
  if [[ "${value}" == /* || "${value}" == */ ]]; then
    fail "--branch must not start or end with '/'"
  fi
  if [[ "${value}" == *. ]]; then
    fail "--branch must not end with '.'"
  fi

  reject_control_chars "${value}" "--branch"

  old_ifs="${IFS}"
  IFS='/'
  read -r -a segments <<<"${value}"
  IFS="${old_ifs}"
  for segment in "${segments[@]}"; do
    case "${segment}" in
      ''|.|..|*.lock)
        fail "--branch must contain only valid Git ref path segments"
        ;;
    esac
  done
}

validate_jenkins_job_path() {
  local value="$1"
  local segment
  local old_ifs

  if [[ -z "${value}" ]]; then
    fail "--pipeline-name must not be empty"
  fi
  if [[ "${value}" == *\\* ]]; then
    fail "--pipeline-name must use '/' for folder paths, got '${value}'"
  fi
  if [[ "${value}" == /* || "${value}" == */ ]]; then
    fail "--pipeline-name must not start or end with '/'"
  fi

  reject_control_chars "${value}" "--pipeline-name"

  old_ifs="${IFS}"
  IFS='/'
  read -r -a segments <<<"${value}"
  IFS="${old_ifs}"
  for segment in "${segments[@]}"; do
    case "${segment}" in
      ''|.|..)
        fail "--pipeline-name must not contain empty, '.', or '..' path segments"
        ;;
    esac
  done
}

encode_jenkins_job_path() {
  local value="$1"
  local old_ifs
  local segment
  local encoded_segment
  local index
  local segment_count
  local -a segments

  validate_jenkins_job_path "${value}"

  encoded_job_path=""
  encoded_job_parent_path=""
  encoded_job_leaf_name=""

  old_ifs="${IFS}"
  IFS='/'
  read -r -a segments <<<"${value}"
  IFS="${old_ifs}"

  segment_count="${#segments[@]}"
  for ((index = 0; index < segment_count; index++)); do
    segment="${segments[$index]}"
    encoded_segment="$(url_encode "${segment}")"
    if [[ -n "${encoded_job_path}" ]]; then
      encoded_job_path+="/"
    fi
    encoded_job_path+="job/${encoded_segment}"
    if (( index < segment_count - 1 )); then
      if [[ -n "${encoded_job_parent_path}" ]]; then
        encoded_job_parent_path+="/"
      fi
      encoded_job_parent_path+="job/${encoded_segment}"
    else
      encoded_job_leaf_name="${encoded_segment}"
    fi
  done
}

print_local_plan() {
  rubble_local_plan
  print_assignment RUBBLE_PUBLISH_SUGGESTED_PIPELINE_NAME "$(default_pipeline_name "${pipeline_id}")"
  print_assignment RUBBLE_PUBLISH_PIPELINE_PATH "${jenkins_pipeline_path}"
}

webhook_observe() {
  "${RUBBLE_EXECUTABLE:-rubble}" script --inherit-env "${script_dir}/${webhook_build_relative}" "$@"
}

rubble_prepare_publication() {
  [[ "${pipeline_mode}" == webhook ]] || return 0
  local prefix
  prefix="$(rubble-exec git -C "${target_root}" rev-parse --show-prefix)"
  [[ -z "${prefix}" && "${jenkins_pipeline_path}" == rubble-generated/Jenkinsfile ]] ||
    fail 'webhook publication requires the build directory at the repository root and rubble-generated/Jenkinsfile'
  if should_wait_for_run_pipeline_build; then
    require_remote_config
    verify_whoami
    prepare_pipeline_name
    api_get "${jenkins_url}/${encoded_job_path}/api/json" "${tmp_dir}/parent.json"
    webhook_observe parent "${tmp_dir}/parent.json"
  fi
}

wait_for_webhook() {
  local published_branch="$1" published_commit="$2" published_repository="$3"
  local start_time status assignments
  start_time="$(rubble_date +%s)"
  # Branch API encodes the slash in the child name; the URL encodes that % again.
  encoded_job_path+="/job/$(url_encode "$(url_encode "${published_branch}")")"
  while true; do
    status="$(curl_status "${tmp_dir}/branch.json" --globoff "${jenkins_url}/${encoded_job_path}/api/json?tree=builds[number],queueItem[url]")"
    if [[ "${status}" == 200 ]]; then
      assignments="$(webhook_observe discover "${tmp_dir}/branch.json" "${jenkins_url}")" || exit 1
      eval "${assignments}"
      if [[ -n "${build_number}" ]]; then break; fi
      if [[ -n "${queue_url}" ]]; then
        wait_for_queue "${queue_url}" "${start_time}"
        break
      fi
    elif [[ "${status}" != 404 ]]; then
      fail "cannot observe Jenkins webhook branch; HTTP ${status}"
    fi
    if [[ "$(( $(rubble_date +%s) - start_time ))" -ge "${queue_timeout_seconds}" ]]; then
      fail "timed out waiting for Jenkins webhook branch ${published_branch}; check GitHub webhook deliveries and Multibranch source configuration"
    fi
    rubble_sleep 2
  done
  wait_for_build
  webhook_observe revision "${tmp_dir}/build.json" "${published_repository}" "${published_commit}"
  RUBBLE_PUBLISH_WAITED=true
  log "Jenkins webhook build succeeded: ${jenkins_url}/${encoded_job_path}/${build_number}/"
}

rubble_publish_remote() {
  local repo_root="$1" prefix="$2" run_branch="$3" published_commit="$4" result
  if [[ "${pipeline_mode}" == webhook ]]; then
    RUBBLE_PUBLISH_WAITED=false
    if should_wait_for_run_pipeline_build; then
      wait_for_webhook "${run_branch}" "${published_commit}" "$(rubble-exec git -C "${repo_root}" remote get-url origin)"
    else
      log "published ${run_branch}; Jenkins will start it through the GitHub webhook"
    fi
    return
  fi
  local arguments=()
  if [[ "${pipeline_mode}" == create ]]; then
    arguments=(--repo-url "$(rubble-exec git -C "${repo_root}" remote get-url origin)" --branch "${run_branch}" --pipeline-path "${prefix}${jenkins_pipeline_path}" --payload-prefix "${prefix%/}" --pipeline-name "${configured_pipeline_name:-$(default_pipeline_name "${pipeline_id}")}")
  fi
  result="$("${rubble}" script --inherit-env --language bash "${RUBBLE_PUBLISH_SCRIPT}" run-pipeline "${arguments[@]}")"
  eval "${result}"
}

load_crumb() {
  local crumb_json="${tmp_dir}/crumb.json"
  local status

  if [[ "${crumb_loaded}" == "true" ]]; then
    return 0
  fi

  crumb_request_field=""
  crumb_value=""

  status="$(curl_status "${crumb_json}" "${jenkins_url}/crumbIssuer/api/json" || true)"
  if [[ "${status}" == "404" ]]; then
    crumb_loaded=true
    return 0
  fi

  if [[ "${status}" -lt 200 || "${status}" -ge 300 ]]; then
    fail "failed to fetch Jenkins crumb; HTTP status ${status}"
  fi

  crumb_request_field="$(json_string_key crumbRequestField "${crumb_json}")"
  crumb_value="$(json_string_key crumb "${crumb_json}")"

  if [[ -z "${crumb_request_field}" || -z "${crumb_value}" ]]; then
    fail "Jenkins crumb response did not include crumbRequestField and crumb"
  fi

  crumb_loaded=true
}

api_get() {
  local url="$1"
  local output_file="$2"
  local curl_args=()
  local status

  if [[ "${pipeline_mode}" != webhook ]]; then load_crumb; fi
  if [[ -n "${crumb_request_field}" ]]; then
    curl_args+=(-H "${crumb_request_field}: ${crumb_value}")
  fi

  status="$(curl_status "${output_file}" "${curl_args[@]}" "${url}" || true)"
  if [[ "${status}" -lt 200 || "${status}" -ge 300 ]]; then
    fail "GET ${url} failed with HTTP status ${status}. Response: $(rubble_cat "${output_file}" 2>/dev/null || true)"
  fi
}

api_post() {
  local url="$1"
  local output_file="$2"
  shift 2

  local curl_args=()
  local status

  load_crumb
  if [[ -n "${crumb_request_field}" ]]; then
    curl_args+=(-H "${crumb_request_field}: ${crumb_value}")
  fi

  status="$(curl_status "${output_file}" -X POST "${curl_args[@]}" "$@" "${url}" || true)"
  if [[ "${status}" -lt 200 || "${status}" -ge 300 ]]; then
    fail "POST ${url} failed with HTTP status ${status}. Response: $(rubble_cat "${output_file}" 2>/dev/null || true)"
  fi
}

verify_whoami() {
  local output_file="${tmp_dir}/whoami.json"
  local authenticated

  api_get "${jenkins_url}/whoAmI/api/json" "${output_file}"
  authenticated="$(json_bool_key authenticated "${output_file}")"

  if [[ "${authenticated}" != "true" ]]; then
    fail "whoAmI verification failed; user is not authenticated: $(rubble_cat "${output_file}")"
  fi
}

jenkins_job_exists() {
  local status_file="${tmp_dir}/job-status.json"
  local curl_args=()
  local status

  load_crumb
  if [[ -n "${crumb_request_field}" ]]; then
    curl_args+=(-H "${crumb_request_field}: ${crumb_value}")
  fi

  status="$(curl_status "${status_file}" "${curl_args[@]}" "${jenkins_url}/${encoded_job_path}/api/json" || true)"
  if [[ "${status}" == "404" ]]; then
    return 1
  fi
  if [[ "${status}" -lt 200 || "${status}" -ge 300 ]]; then
    fail "failed to check Jenkins job '${pipeline_name}'; HTTP status ${status}. Response: $(rubble_cat "${status_file}" 2>/dev/null || true)"
  fi
  return 0
}

write_job_config() {
  local job_xml="${tmp_dir}/job-config.xml"
  local escaped_repo_url
  local escaped_branch
  local escaped_script_path
  local escaped_payload_prefix
  local escaped_max_running
  local escaped_max_ready


  escaped_repo_url="$(xml_escape "${repo_url}")"
  escaped_branch="$(xml_escape "${branch_spec}")"
  escaped_script_path="$(xml_escape "${pipeline_path}")"
  escaped_payload_prefix="$(xml_escape "${payload_prefix}")"
  escaped_max_running="$(xml_escape "3")"
  escaped_max_ready="$(xml_escape "8")"

  rubble_cat >"${job_xml}" <<EOF
<?xml version='1.0' encoding='UTF-8'?>
<flow-definition plugin="workflow-job">
  <actions/>
  <description>Managed by Rubble Jenkins publisher. This job is a one-shot SCM Pipeline for ${root_short}.</description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <hudson.model.ParametersDefinitionProperty>
      <parameterDefinitions>

        <hudson.model.StringParameterDefinition>
          <name>RUBBLE_PUBLISH_PAYLOAD_PREFIX</name>
          <description>Repository-relative path to the Rubble publish target directory. Empty means repository root directory.</description>
          <defaultValue>${escaped_payload_prefix}</defaultValue>
        </hudson.model.StringParameterDefinition>
        <hudson.model.StringParameterDefinition>
          <name>RUBBLE_PUBLISH_MAX_RUNNING</name>
          <description>Maximum number of Rubble DAG tasks allowed to run at once.</description>
          <defaultValue>${escaped_max_running}</defaultValue>
        </hudson.model.StringParameterDefinition>
        <hudson.model.StringParameterDefinition>
          <name>RUBBLE_PUBLISH_MAX_READY</name>
          <description>Maximum number of Rubble DAG tasks allowed to wait for executor slots at once.</description>
          <defaultValue>${escaped_max_ready}</defaultValue>
        </hudson.model.StringParameterDefinition>
      </parameterDefinitions>
    </hudson.model.ParametersDefinitionProperty>
  </properties>
  <definition class="org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition" plugin="workflow-cps">
    <scm class="hudson.plugins.git.GitSCM" plugin="git">
      <configVersion>2</configVersion>
      <userRemoteConfigs>
        <hudson.plugins.git.UserRemoteConfig>
          <url>${escaped_repo_url}</url>
        </hudson.plugins.git.UserRemoteConfig>
      </userRemoteConfigs>
      <branches>
        <hudson.plugins.git.BranchSpec>
          <name>${escaped_branch}</name>
        </hudson.plugins.git.BranchSpec>
      </branches>
      <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
      <submoduleCfg class="empty-list"/>
      <extensions/>
    </scm>
    <scriptPath>${escaped_script_path}</scriptPath>
    <lightweight>false</lightweight>
  </definition>
  <triggers/>
  <disabled>false</disabled>
</flow-definition>
EOF

  printf '%s' "${job_xml}"
}

ensure_job() {
  local job_xml create_url
  if [[ "${pipeline_mode}" == existing ]]; then
    jenkins_job_exists || fail "configured Jenkins job '${pipeline_name}' does not exist; create/configure it before retrying"
    log "using user-maintained Jenkins job ${pipeline_name}"
    return
  fi
  if jenkins_job_exists; then
    fail "Jenkins job '${pipeline_name}' already exists; create mode requires a new name (use existing mode for deliberate reuse)"
  fi
  prepare_pipeline_definition
  job_xml="$(write_job_config)"
  if [[ -n "${encoded_job_parent_path}" ]]; then
    create_url="${jenkins_url}/${encoded_job_parent_path}/createItem?name=${encoded_job_leaf_name}"
  else
    create_url="${jenkins_url}/createItem?name=${encoded_job_leaf_name}"
  fi
  log "creating Jenkins Pipeline job ${pipeline_name}; the API token must have job creation permission"
  api_post "${create_url}" "${tmp_dir}/create-job.out" \
    -H 'Content-Type: application/xml' --data-binary "@${job_xml}"
}

inspect_job_parameters() {
  local parameter_file="${tmp_dir}/job-parameters.json"
  local status
  status="$(curl_status "${parameter_file}" --globoff "${jenkins_url}/${encoded_job_path}/api/json?tree=property[parameterDefinitions[name]]")"
  [[ "${status}" -ge 200 && "${status}" -lt 300 ]] || fail "cannot inspect Jenkins job '${pipeline_name}' parameters; HTTP ${status}"
  local required_parameter=''

  job_trigger_requires_parameters="$("${RUBBLE_EXECUTABLE:-rubble}" script --inherit-env \
    "${script_dir}/${job_parameters_relative}" "${parameter_file}" "${required_parameter}")" || exit 1
}

trigger_job() {
  local headers_file="${tmp_dir}/build.headers"
  local body_file="${tmp_dir}/build.body"
  local curl_args=()
  local build_url
  local status
  local location

  inspect_job_parameters

  load_crumb
  if [[ -n "${crumb_request_field}" ]]; then
    curl_args+=(-H "${crumb_request_field}: ${crumb_value}")
  fi

  log "triggering Jenkins job ${pipeline_name}"
  if [[ "${job_trigger_requires_parameters}" == "true" ]]; then
    build_url="${jenkins_url}/${encoded_job_path}/buildWithParameters"
  else
    build_url="${jenkins_url}/${encoded_job_path}/build"
  fi
  status="$(rubble_curl -sS --config "${curl_config_file}" -D "${headers_file}" -o "${body_file}" -w '%{http_code}' -X POST "${curl_args[@]}" "${build_url}" || true)"


  if [[ "${status}" -lt 200 || "${status}" -ge 300 ]]; then
    fail "build trigger failed with HTTP status ${status}. URL: ${build_url}"
  fi

  location="$(rubble_tr -d '\r' <"${headers_file}" | rubble_awk 'tolower($1) == "location:" {print $2; exit}')"
  if [[ -z "${location}" ]]; then
    fail "build trigger did not return a queue Location header"
  fi

  printf '%s' "${location}"
}

wait_for_queue() {
  local location="$1"
  local queue_api="${location%/}/api/json"
  local queue_json="${tmp_dir}/queue.json"
  local start_time
  local cancelled

  start_time="${2:-$(rubble_date +%s)}"
  while true; do
    api_get "${queue_api}" "${queue_json}"
    build_number="$(queue_build_number "${queue_json}")"
    if [[ -n "${build_number}" ]]; then
      log "Jenkins queue assigned build number ${build_number}"
      return
    fi

    cancelled="$(queue_cancelled "${queue_json}")"
    if [[ "${cancelled}" == "true" ]]; then
      fail "Jenkins queue item was cancelled: $(rubble_cat "${queue_json}")"
    fi

    if [[ "$(( $(rubble_date +%s) - start_time ))" -ge "${queue_timeout_seconds}" ]]; then
      fail "timed out waiting for Jenkins queue executable. Last queue response: $(rubble_cat "${queue_json}")"
    fi

    rubble_sleep 2
  done
}

fetch_console_log() {
  console_log_file="${tmp_dir}/console.log"
  api_get "${jenkins_url}/${encoded_job_path}/${build_number}/consoleText" "${console_log_file}"
}

fail_with_console() {
  local message="$1"

  if [[ -n "${console_log_file}" && -f "${console_log_file}" ]]; then
    log "last Jenkins console lines:"
    rubble_tail -n 200 "${console_log_file}" >&2 || true
  fi
  fail "${message}"
}

wait_for_build() {
  local build_json="${tmp_dir}/build.json"
  local start_time
  local building

  start_time="$(rubble_date +%s)"
  while true; do
    api_get "${jenkins_url}/${encoded_job_path}/${build_number}/api/json" "${build_json}"
    building="$(json_bool_key building "${build_json}")"
    build_result="$(json_string_key result "${build_json}")"

    if [[ "${building}" == "false" ]]; then
      break
    fi

    if [[ "$(( $(rubble_date +%s) - start_time ))" -ge "${build_timeout_seconds}" ]]; then
      fetch_console_log || true
      fail_with_console "timed out waiting for Jenkins build ${build_number} to finish"
    fi

    rubble_sleep 3
  done

  fetch_console_log || true
  if [[ "${build_result}" != "SUCCESS" ]]; then
    fail_with_console "Jenkins build ${build_number} finished with result ${build_result}"
  fi
}

require_option_value() {
  local option="$1"
  local value="${2:-}"

  if [[ -z "${value}" ]]; then
    fail "${option} requires a value"
  fi
}

reset_pipeline_args() {
  pipeline_name=""
  encoded_job_path=""
  encoded_job_parent_path=""
  encoded_job_leaf_name=""
  repo_url=""
  branch=""
  branch_spec=""
  pipeline_path=""
  payload_prefix=""
  payload_prefix_was_set=false
  pipeline_name_override="${configured_pipeline_name}"
  queue_url=""
  pipeline_definition_prepared=false
  job_trigger_requires_parameters=false
}

parse_pipeline_args() {
  reset_pipeline_args

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --repo-url)
        require_option_value "$1" "${2:-}"
        repo_url="$2"
        shift 2
        ;;
      --branch)
        require_option_value "$1" "${2:-}"
        branch="$2"
        shift 2
        ;;
      --pipeline-path)
        require_option_value "$1" "${2:-}"
        pipeline_path="$2"
        shift 2
        ;;
      --payload-prefix)
        if [[ $# -lt 2 ]]; then
          fail "--payload-prefix requires a value"
        fi
        payload_prefix="$2"
        payload_prefix_was_set=true
        shift 2
        ;;
      --target-prefix)
        fail "--target-prefix is no longer used; publish the Jenkins payload at the repository-relative path named by --pipeline-path"
        ;;
      --pipeline-name)
        require_option_value "$1" "${2:-}"
        pipeline_name_override="$2"
        shift 2
        ;;
      --queue-url)
        require_option_value "$1" "${2:-}"
        queue_url="$2"
        shift 2
        ;;
      *)
        fail "unknown option for Jenkins publisher subcommand: $1"
        ;;
    esac
  done
}

parse_trigger_args() {
  reset_pipeline_args

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --pipeline-name)
        require_option_value "$1" "${2:-}"
        pipeline_name_override="$2"
        shift 2
        ;;
      --repo-url|--branch|--pipeline-path|--payload-prefix|--queue-url)
        fail "trigger-pipeline only accepts --pipeline-name; use ensure-pipeline or run-pipeline for Jenkins job creation facts"
        ;;
      --target-prefix)
        fail "--target-prefix is no longer used; publish the Jenkins payload at the repository-relative path named by --pipeline-path"
        ;;
      *)
        fail "unknown option for trigger-pipeline: $1"
        ;;
    esac
  done

  if [[ -z "${pipeline_name_override}" ]]; then
    fail "--pipeline-name is required for trigger-pipeline"
  fi
}

parse_wait_args() {
  reset_pipeline_args

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --pipeline-name)
        require_option_value "$1" "${2:-}"
        pipeline_name_override="$2"
        shift 2
        ;;
      --queue-url)
        require_option_value "$1" "${2:-}"
        queue_url="$2"
        shift 2
        ;;
      --repo-url|--branch|--pipeline-path|--payload-prefix)
        fail "wait-pipeline only accepts --pipeline-name and --queue-url"
        ;;
      --target-prefix)
        fail "--target-prefix is no longer used"
        ;;
      *)
        fail "unknown option for wait-pipeline: $1"
        ;;
    esac
  done
}

require_remote_config() {
  jenkins_url="${RUBBLE_BUILD_BUILDER_JENKINS_URL:-}"
  jenkins_url="${jenkins_url%/}"
  jenkins_user="${RUBBLE_BUILD_BUILDER_JENKINS_USER:-admin}"
  api_token="${RUBBLE_BUILD_BUILDER_JENKINS_TOKEN:-}"
  api_token_file="${RUBBLE_BUILD_BUILDER_JENKINS_TOKEN_FILE:-}"
  queue_timeout_seconds="${RUBBLE_BUILD_BUILDER_JENKINS_QUEUE_TIMEOUT_SECONDS:-180}"
  build_timeout_seconds="${RUBBLE_BUILD_BUILDER_JENKINS_BUILD_TIMEOUT_SECONDS:-300}"

  require_positive_integer RUBBLE_BUILD_BUILDER_JENKINS_QUEUE_TIMEOUT_SECONDS "${queue_timeout_seconds}"
  require_positive_integer RUBBLE_BUILD_BUILDER_JENKINS_BUILD_TIMEOUT_SECONDS "${build_timeout_seconds}"

  if [[ -z "${api_token}" && -n "${api_token_file}" ]]; then
    if [[ ! -f "${api_token_file}" ]]; then
      fail "Jenkins token file does not exist: ${api_token_file}"
    fi
    api_token="$(trim_file "${api_token_file}")"
  fi

  if [[ -z "${jenkins_url}" || -z "${api_token}" ]]; then
    fail "Jenkins URL and API token are required for remote subcommands; rerun through 'rubble build --builder jenkins ...' or export RUBBLE_BUILD_BUILDER_JENKINS_URL plus RUBBLE_BUILD_BUILDER_JENKINS_TOKEN/RUBBLE_BUILD_BUILDER_JENKINS_TOKEN_FILE"
  fi

  ensure_tmp_dir
  write_curl_config
}

should_wait_for_run_pipeline_build() {
  local value="${RUBBLE_BUILD_BUILDER_JENKINS_WAIT:-true}"

  case "${value}" in
    true)
      return 0
      ;;
    false)
      return 1
      ;;
    *)
      fail "RUBBLE_BUILD_BUILDER_JENKINS_WAIT must be 'true' or 'false', got '${value}'"
      ;;
  esac
}

derive_pipeline_name() {
  if [[ -n "${pipeline_name_override}" ]]; then
    printf '%s' "${pipeline_name_override}"
    return
  fi

  default_pipeline_name "$(rubble_date -u +%Y%m%dT%H%M%SZ)-$$"
}

prepare_pipeline_name() {
  pipeline_name="$(derive_pipeline_name)"
  encode_jenkins_job_path "${pipeline_name}"
}

prepare_pipeline_definition() {
  if [[ -z "${repo_url}" ]]; then
    fail "--repo-url is required"
  fi
  if [[ -z "${branch}" ]]; then
    fail "--branch is required"
  fi
  if [[ -z "${pipeline_path}" ]]; then
    fail "--pipeline-path is required"
  fi
  if [[ "${payload_prefix_was_set}" != "true" ]]; then
    fail "--payload-prefix is required; pass an empty string when the payload is at the repository root"
  fi

  validate_repo_relative_path "${pipeline_path}" "--pipeline-path" false
  validate_repo_relative_path "${payload_prefix}" "--payload-prefix" true
  validate_branch_name "${branch}"
  case "${branch}" in
    refs/*)
      branch_spec="${branch}"
      ;;
    *)
      branch_spec="origin/${branch}"
      ;;
  esac
  pipeline_definition_prepared=true
  if [[ -z "${pipeline_name}" ]]; then
    prepare_pipeline_name
  fi
}

print_pipeline_assignments() {
  print_assignment RUBBLE_PUBLISH_PIPELINE_NAME "${pipeline_name}"
  if [[ "${pipeline_definition_prepared}" == "true" ]]; then
    [[ -z "${repo_url}" ]] || print_assignment RUBBLE_PUBLISH_REPO_URL "${repo_url}"
    [[ -z "${branch}" ]] || print_assignment RUBBLE_PUBLISH_BRANCH "${branch}"
    [[ -z "${pipeline_path}" ]] || print_assignment RUBBLE_PUBLISH_PIPELINE_PATH "${pipeline_path}"
    print_assignment RUBBLE_PUBLISH_PAYLOAD_PREFIX "${payload_prefix}"
  fi
}

cmd_default_pipeline_name() {
  local timestamp

  reset_pipeline_args
  if [[ $# -ne 0 ]]; then
    fail "default-pipeline-name does not accept options"
  fi

  timestamp="$(rubble_date -u +%Y%m%dT%H%M%SZ)-$$"
  pipeline_name="$(default_pipeline_name "${timestamp}")"
  print_assignment RUBBLE_PUBLISH_PIPELINE_NAME "${pipeline_name}"
}

cmd_ensure_pipeline() {
  parse_pipeline_args "$@"
  prepare_pipeline_name
  require_remote_config
  verify_whoami
  ensure_job
  print_pipeline_assignments
}

cmd_trigger_pipeline() {
  parse_trigger_args "$@"
  prepare_pipeline_name
  require_remote_config
  queue_url="$(trigger_job)"
  print_pipeline_assignments
  print_assignment RUBBLE_PUBLISH_QUEUE_URL "${queue_url}"
}

cmd_wait_pipeline() {
  parse_wait_args "$@"
  if [[ -z "${queue_url}" ]]; then
    fail "--queue-url is required"
  fi
  if [[ -z "${pipeline_name_override}" ]]; then
    fail "--pipeline-name is required for wait-pipeline; pass RUBBLE_PUBLISH_PIPELINE_NAME from trigger-pipeline"
  fi
  prepare_pipeline_name
  require_remote_config
  wait_for_queue "${queue_url}"
  wait_for_build
  print_pipeline_assignments
  print_assignment RUBBLE_PUBLISH_QUEUE_URL "${queue_url}"
  print_assignment RUBBLE_PUBLISH_BUILD_NUMBER "${build_number}"
  print_assignment RUBBLE_PUBLISH_BUILD_RESULT "${build_result}"
  print_assignment RUBBLE_PUBLISH_CONSOLE_URL "${jenkins_url}/${encoded_job_path}/${build_number}/consoleText"
}

cmd_run_pipeline() {
  local wait_for_build

  parse_pipeline_args "$@"
  prepare_pipeline_name
  require_remote_config
  verify_whoami
  ensure_job

  if should_wait_for_run_pipeline_build; then
    wait_for_build=true
  else
    wait_for_build=false
  fi

  queue_url="$(trigger_job)"

  if [[ "${wait_for_build}" != "true" ]]; then
    print_pipeline_assignments
    print_assignment RUBBLE_PUBLISH_QUEUE_URL "${queue_url}"
    print_assignment RUBBLE_PUBLISH_WAITED "false"
    exit 0
  fi

  wait_for_queue "${queue_url}"
  wait_for_build
  print_pipeline_assignments
  print_assignment RUBBLE_PUBLISH_QUEUE_URL "${queue_url}"
  print_assignment RUBBLE_PUBLISH_WAITED "true"
  print_assignment RUBBLE_PUBLISH_BUILD_NUMBER "${build_number}"
  print_assignment RUBBLE_PUBLISH_BUILD_RESULT "${build_result}"
  print_assignment RUBBLE_PUBLISH_CONSOLE_URL "${jenkins_url}/${encoded_job_path}/${build_number}/consoleText"
}

usage() {
  rubble_cat >&2 <<'EOF'
usage: jenkins-publish.sh [publish|default-publish|local-plan|default-pipeline-name|ensure-pipeline|trigger-pipeline|wait-pipeline|run-pipeline] [options]

default-pipeline-name accepts no options.
trigger-pipeline requires --pipeline-name.
wait-pipeline requires --pipeline-name and --queue-url from trigger-pipeline output.

remote options:
  --repo-url URL
  --branch BRANCH
  --pipeline-path PATH
  --payload-prefix PREFIX
  --pipeline-name NAME_OR_FOLDER_PATH
  --queue-url URL
EOF
}

if [[ "${pipeline_mode}" == webhook ]]; then
  case "${1:-}" in
    ensure-pipeline|trigger-pipeline|run-pipeline|wait-pipeline)
      fail 'webhook mode observes publication through the fixed Multibranch Pipeline; API pipeline subcommands are unavailable' ;;
  esac
fi

case "${1:-}" in
  ""|publish)
    publish
    ;;
  default-publish)
    default_publish
    ;;
  local-plan)
    shift
    if [[ $# -ne 0 ]]; then
      usage
      exit 2
    fi
    print_local_plan
    ;;
  default-pipeline-name)
    shift
    cmd_default_pipeline_name "$@"
    ;;
  ensure-pipeline)
    shift
    cmd_ensure_pipeline "$@"
    ;;
  trigger-pipeline)
    shift
    cmd_trigger_pipeline "$@"
    ;;
  wait-pipeline)
    shift
    cmd_wait_pipeline "$@"
    ;;
  run-pipeline)
    shift
    cmd_run_pipeline "$@"
    ;;
  -h|--help|help)
    usage
    ;;
  *)
    usage
    fail "unknown Jenkins publisher command: $1"
    ;;
esac