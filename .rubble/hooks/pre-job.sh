set -euo pipefail
[[ "$RUBBLE_BUILD_PLATFORM" == x86_64-linux ]]
printf "[acceptance] pre-job brick=%s temp=%s\n" "$RUBBLE_BRICK_ID" "$RUBBLE_JOB_TEMP"
