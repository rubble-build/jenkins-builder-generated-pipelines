#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

source "${RUBBLE_CI_RUNTIME:?}"
if ! rubble_hook_present prepare-release; then
  printf '[remote-release] prepare-release hook is absent or empty; skipping\n' >&2
  exit 0
fi

release_dir="$(rubble-exec mktemp -d "${RUBBLE_JOB_TEMP:?}/rubble-release.XXXXXXXX")"
export RUBBLE_RELEASE_DIR="${release_dir}"
cleanup_release() {
  local status=$?
  trap - EXIT
  if ! rubble-exec rm -rf -- "${release_dir}"; then
    ((status != 0)) || status=1
  fi
  exit "${status}"
}
trap cleanup_release EXIT
rubble-exec mkdir -p -- "${release_dir}/assets"

script_dir="$(builtin cd -- "$(rubble-exec dirname -- "${BASH_SOURCE[0]}")" && builtin pwd)"
release_brick_files=(

  'store/4a/kg/brk-4akgeqh75ykzzoxsujyb6van57gvy7xjogx47zvqthh6ka6oaddq-webhook-20260917-base.brick'

  'store/vo/zs/brk-vozsoti3hfmeatsb2pjdqyclnri7gpzau67jimnqlrqjmqtbxrma-webhook-20260917-right.brick'

  'store/rl/yf/brk-rlyfx2rjtq37plu6ynf3f5i63u62yfpxg3vgw5q6r7dvq6p35fka-webhook-20260917-left.brick'

  'store/jo/q7/brk-joq7biykf72mbynxaicjf2uyagk2qe5pfsgq74w76mpx54bduhna-webhook-20260917-small-root.brick'

)
for relative in "${release_brick_files[@]}"; do
  "${rubble}" --no-banner pull --depth 1 --unpack -r "${RUBBLE_REMOTE_STORE}" "${script_dir}/${relative}"
done
rubble_run_hook prepare-release

shopt -s nullglob dotglob
assets=()
for asset in "${release_dir}/assets/"*; do
  [[ -f "${asset}" && ! -L "${asset}" ]] && assets+=("${asset}")
done
if ((${#assets[@]} == 0)); then
  printf '[remote-release] no prepared assets; skipping\n' >&2
  exit 0
fi

user_release_relative='../../.rubble/release.sh'
if [[ -s "${script_dir}/${user_release_relative}" ]]; then
  "${rubble}" script --inherit-env "${script_dir}/${user_release_relative}"
fi