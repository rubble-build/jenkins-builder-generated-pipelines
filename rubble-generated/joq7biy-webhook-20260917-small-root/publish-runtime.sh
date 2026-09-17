publication_dir="$(builtin cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && builtin pwd)"
# Shared local publication context and lifecycle. Sourced by a service adapter.
lifecycle_relative='lifecycle.sh'
source "${publication_dir}/${lifecycle_relative}"
target_root_relative='../..'
payload_root_relative='.'
root_brick_relative='store/jo/q7/brk-joq7biykf72mbynxaicjf2uyagk2qe5pfsgq74w76mpx54bduhna-webhook-20260917-small-root.brick'
target_root="$(builtin cd "${publication_dir}/${target_root_relative}" && builtin pwd)"
payload_dir="$(builtin cd "${publication_dir}/${payload_root_relative}" && builtin pwd)"
root_brick="${publication_dir}/${root_brick_relative}"
user_publish_relative='../../.rubble/publish.sh'
user_publish_script="${publication_dir}/${user_publish_relative}"
root_id='joq7biykf72mbynxaicjf2uyagk2qe5pfsgq74w76mpx54bduhna-webhook-20260917-small-root'
root_name='webhook-20260917-small-root'
pipeline_id='56e019cf-25be-4cb4-9366-2f08f58c9cb1'
pipeline_branch="runs/${pipeline_id}"
generated_root='rubble-generated/joq7biy-webhook-20260917-small-root'
managed_output_paths=(

  '.rubble/hooks'

  '.rubble/hooks/post-job.sh'

  '.rubble/hooks/post-publish.sh'

  '.rubble/hooks/post-release.sh'

  '.rubble/hooks/pre-job.sh'

  '.rubble/hooks/pre-publish.sh'

  '.rubble/hooks/prepare-release.sh'

  '.rubble/publish.sh'

  '.rubble/release.sh'

  'rubble-generated'

  'rubble-generated/Jenkinsfile'

  'rubble-generated/joq7biy-webhook-20260917-small-root/authentication.sh'

  'rubble-generated/joq7biy-webhook-20260917-small-root/build-brick.sh'

  'rubble-generated/joq7biy-webhook-20260917-small-root/cleanup-auth.sh'

  'rubble-generated/joq7biy-webhook-20260917-small-root/jenkins-job-parameters.mjs'

  'rubble-generated/joq7biy-webhook-20260917-small-root/jenkins-publish.sh'

  'rubble-generated/joq7biy-webhook-20260917-small-root/jenkins-webhook-build.mjs'

  'rubble-generated/joq7biy-webhook-20260917-small-root/lifecycle.sh'

  'rubble-generated/joq7biy-webhook-20260917-small-root/publish-runtime.sh'

  'rubble-generated/joq7biy-webhook-20260917-small-root/release-inventory.txt'

  'rubble-generated/joq7biy-webhook-20260917-small-root/release-root.sh'

  'rubble-generated/joq7biy-webhook-20260917-small-root/rubble-manifest-joq7biykf72mbynxaicjf2uyagk2qe5pfsgq74w76mpx54bduhna-webhook-20260917-small-root.json'

  'rubble-generated/joq7biy-webhook-20260917-small-root/store/4a/kg/brk-4akgeqh75ykzzoxsujyb6van57gvy7xjogx47zvqthh6ka6oaddq-webhook-20260917-base.brick'

  'rubble-generated/joq7biy-webhook-20260917-small-root/store/jo/q7/brk-joq7biykf72mbynxaicjf2uyagk2qe5pfsgq74w76mpx54bduhna-webhook-20260917-small-root.brick'

  'rubble-generated/joq7biy-webhook-20260917-small-root/store/rl/yf/brk-rlyfx2rjtq37plu6ynf3f5i63u62yfpxg3vgw5q6r7dvq6p35fka-webhook-20260917-left.brick'

  'rubble-generated/joq7biy-webhook-20260917-small-root/store/vo/zs/brk-vozsoti3hfmeatsb2pjdqyclnri7gpzau67jimnqlrqjmqtbxrma-webhook-20260917-right.brick'

)

log() {
  printf '[remote-publish] %s\n' "$1" >&2
}

fail() {
  log "ERROR: $1"
  exit 1
}

shell_quote() {
  local value="$1"
  printf "'"
  printf '%s' "${value}" | rubble-exec sed "s/'/'\\\\''/g"
  printf "'"
}

print_assignment() {
  printf '%s=%s\n' "$1" "$(shell_quote "$2")"
}

rubble_local_plan() {
  print_assignment RUBBLE_PUBLISH_SUGGESTED_BRANCH "${pipeline_branch}"
  print_assignment RUBBLE_PUBLISH_PIPELINE_ID "${pipeline_id}"
  print_assignment RUBBLE_PUBLISH_GENERATED_ROOT "${generated_root}"
  print_assignment RUBBLE_PUBLISH_OUTPUT_COUNT "${#managed_output_paths[@]}"
  local index
  for index in "${!managed_output_paths[@]}"; do
    print_assignment "RUBBLE_PUBLISH_OUTPUT_${index}" "${managed_output_paths[$index]}"
  done
}

publish_git() (
  local repo_root target_prefix base_branch unrelated branch index_directory tree commit
  repo_root="$(rubble-exec git -C "${target_root}" rev-parse --show-toplevel)"
  target_prefix="$(rubble-exec git -C "${target_root}" rev-parse --show-prefix)"
  base_branch="$(rubble-exec git -C "${repo_root}" branch --show-current)"
  [[ -n "${base_branch}" ]] || fail "publishing requires a named base branch"
  local -a paths=() status_pathspecs=(.) pathspecs=()
  local path tracked
  for path in "${managed_output_paths[@]}"; do
    paths+=("${target_prefix}${path}")
    status_pathspecs+=(":(exclude,literal)${target_prefix}${path}")
  done
  unrelated="$(rubble-exec git --no-optional-locks -C "${repo_root}" status --porcelain --untracked-files=all -- "${status_pathspecs[@]}")"
  [[ -z "${unrelated}" ]] || fail "repository has unrelated changes; commit or remove them before publishing"
  branch="${pipeline_branch}"
  if rubble-exec git -C "${repo_root}" show-ref --verify --quiet "refs/heads/${branch}" || \
     rubble-exec git -C "${repo_root}" ls-remote --exit-code --heads origin "refs/heads/${branch}" >/dev/null 2>&1; then
    fail "one-use pipeline branch already exists: ${branch}"
  fi

  # Build the run commit without consuming local hook edits or changing the caller's index/branch.
  index_directory="$(rubble-exec mktemp -d "$(rubble-exec git -C "${repo_root}" rev-parse --path-format=absolute --git-common-dir)/rubble-publish.XXXXXXXX")"
  trap 'rubble-exec rm -rf -- "${index_directory}"' EXIT
  local original_index="${GIT_INDEX_FILE-}" original_index_set="${GIT_INDEX_FILE+x}"
  export GIT_INDEX_FILE="${index_directory}/index"
  rubble-exec git -C "${repo_root}" read-tree HEAD
  for path in "${paths[@]}"; do
    # Missing optional hooks are valid. Keep tracked deletions, using the run index rather than the caller's.
    if [[ ! -e "${repo_root}/${path}" && ! -L "${repo_root}/${path}" ]]; then
      tracked="$(rubble-exec git -C "${repo_root}" ls-files -- ":(literal)${path}")"
      [[ -n "${tracked}" ]] || continue
    fi
    pathspecs+=(":(literal)${path}")
  done
  rubble-exec git -C "${repo_root}" add -A -- "${pathspecs[@]}"
  tree="$(rubble-exec git -C "${repo_root}" write-tree)"
  commit="$(rubble-exec git -C "${repo_root}" commit-tree "${tree}" -p HEAD -m "Run Rubble workflow for ${root_id}")"
  rubble-exec git -C "${repo_root}" update-ref "refs/heads/${branch}" "${commit}" ''
  rubble-exec git -C "${repo_root}" push origin "refs/heads/${branch}:refs/heads/${branch}"
  # Service adapters and user hooks retain the caller's Git context.
  if [[ "${original_index_set}" == x ]]; then
    export GIT_INDEX_FILE="${original_index}"
  else
    unset GIT_INDEX_FILE
  fi
  rubble_publish_remote "${repo_root}" "${target_prefix}" "${branch}" "${commit}"
  if [[ "${RUBBLE_PUBLISH_WAITED}" == true ]]; then rubble_run_hook post-publish; fi
)

consume_pipeline_identity() {
  local state_file
  state_file="$(pipeline_state_file used)"
  if ! (set -o noclobber; printf '%s\n' "${pipeline_id}" >"${state_file}") 2>/dev/null; then
    fail "pipeline identity has already been consumed; run Rubble again to create a new pipeline"
  fi
  rubble-exec chmod 600 "${state_file}"
  log "consumed one-use pipeline identity ${pipeline_id}"
}

pipeline_state_file() {
  local suffix="$1"
  local git_common_dir
  local state_dir
  git_common_dir="$(rubble-exec git -C "${target_root}" rev-parse --path-format=absolute --git-common-dir)"
  state_dir="${git_common_dir}/rubble-pipelines"
  rubble-exec mkdir -p "${state_dir}" || return 1
  rubble-exec chmod 700 "${state_dir}" || return 1
  printf '%s/%s.%s\n' "${state_dir}" "${pipeline_id}" "${suffix}"
}


publish_context() {
  export RUBBLE_PUBLISH_TARGET_ROOT="${target_root}"
  export RUBBLE_PUBLISH_PAYLOAD_DIR="${payload_dir}"
  export RUBBLE_PUBLISH_ROOT_ID="${root_id}"
  export RUBBLE_PUBLISH_ROOT_NAME="${root_name}"
  export RUBBLE_PUBLISH_PIPELINE_ID="${pipeline_id}"
}

publish() {
  if [[ ! -f "${user_publish_script}" || ! -s "${user_publish_script}" ]]; then
    log "user publisher is absent or empty; skipping publication"
    return 0
  fi
  publish_context
  (builtin cd -- "${target_root}" && "${rubble}" script --inherit-env "${user_publish_script}")
}

default_publish() {
  publish_context
  rubble_run_hook pre-publish
  consume_pipeline_identity
  rubble_prepare_publication
  publish_git
}