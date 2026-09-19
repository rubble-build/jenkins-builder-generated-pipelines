publication_dir="$(builtin cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && builtin pwd)"
# Shared local publication context and lifecycle. Sourced by a service adapter.
lifecycle_relative='lifecycle.sh'
export RUBBLE_CI_JOB_KIND=publish
source "${publication_dir}/${lifecycle_relative}"
target_root_relative='../..'
payload_root_relative='.'
target_root="$(builtin cd "${publication_dir}/${target_root_relative}" && builtin pwd)"
payload_dir="$(builtin cd "${publication_dir}/${payload_root_relative}" && builtin pwd)"
user_publish_relative='../../.rubble/publish.sh'
user_publish_script="${publication_dir}/${user_publish_relative}"
plan_id='tfagkogbrwgn4fra5ytt4jabozu7lrt6jslw5pzrrauh6464cuoa-python3-glibc-3.13.13'
pipeline_id='ba2c717b-3532-4873-9b88-4effc86a5c55'
pipeline_branch="runs/${pipeline_id}"
generated_root='rubble-generated/tfagkog-python3-glibc-3.13.13'
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

  'rubble-generated/tfagkog-python3-glibc-3.13.13/authentication.sh'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/build-brick.sh'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/cleanup-auth.sh'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/jenkins-job-parameters.mjs'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/jenkins-publish.sh'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/jenkins-webhook-build.mjs'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/lifecycle.sh'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/publish-runtime.sh'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/release-inventory.txt'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/release-plan.sh'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/rubble-manifest-tfagkogbrwgn4fra5ytt4jabozu7lrt6jslw5pzrrauh6464cuoa-python3-glibc-3.13.13.json'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/26/tn/brk-26tn2yq4ryvlust5j46r2gfdg7ew7zg7gpth4bowtw5vxvj5xeiq-findutils.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/2g/nn/brk-2gnnygccogetfxv3mfq5wrsghkq4swdc45zuyny7q3jyhq5xwe3a-mpc-1.2.1.tar.gz.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/3y/ms/brk-3ymsqx4irog2cwz3opdekqpw4otufpn5qdjdmbgzswfjrt23imbq-zstd.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/46/lf/brk-46lfnhiwl7xwedh2m5nqmsiz53zc3vcpqiox4v4mctm56nzwlz6a-bootstrap-env.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/4w/qt/brk-4wqtammobxoyixq6mok6psj2mp6d3pjlgjjgooaxh3pqxhhwxf2a-zlib-1.3.2-r0.apk.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/5a/px/brk-5apxix5e5vnkwoe4owil4q6x64de3qdxlialv3vbeibr6pzhxada-bootstrap-build-tools.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/6f/kb/brk-6fkbbg6pc4yfhgvgo5pvqnh3447niza2cjqxt27aibzytwyzdj7a-mpfr-4.1.0.tar.bz2.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/6f/yi/brk-6fyi5giuhq2rktxlfg2epgwit5rqik345vr2o25yognyocmskspq-gnu-tar.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/6i/tb/brk-6itbkpqgk46i34vxf2bxe2jjugitys6463c73qfk5fhiipwku4ha-gnu-sed.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/6p/4c/brk-6p4ctsz2fw6i3hw3toxuwyxyzrwpcuouxzy5dez6yxyv4uivhxzq-glibc-headers.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/6q/yw/brk-6qywaqu63vt3ydbo74p2fqxifkn77izwg5amobej6nca3oao2xla-isl-0.24.tar.bz2.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/7x/yx/brk-7xyxj2gbjwpxtezphrdodjfdexxgf7edctmubyozr5rbvwz6yjqq-glibc-native.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/ad/cr/brk-adcrhlud4lao22xpeqdtkmm3cbdxrk4yn7hqqh4y2wguzsupqiqq-curl.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/ap/wv/brk-apwv2emy6cpgfjhifot4on26vbuiigqxu2nabpoyf42xknawsowa-gmp-6.2.1.tar.bz2.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/b6/du/brk-b6du7m4wvh6hhvuzjxtbgjxv3kmgap4w2jh2mjw7ztfs2mbseida-gzip.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/bt/u4/brk-btu4wdeflhf6iv4rk4awpoj4h3ke6bdsgsdmdj6icerqhprab2zq-bison.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/bx/ch/brk-bxchorbehgapcopsqwo7w5zwjgenujywlkkytlnad3dvy5hpqc5q-bash.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/cc/a6/brk-cca6hpdxtvtjn3hkbljrizdlu2cpldgeodds67hxlcf2nhclfc5a-m4.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/cd/gy/brk-cdgy6susoq245z4mch7qbgfzwfyqzywqchtfoveem66yiwhb4qba-gnu-make.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/cm/5l/brk-cm5le2xhmapvc7ocadlvrx3k7n7bf35nr6rodwvc5fktgx62urkq-zlib-1.3.2.tar.gz.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/dt/7i/brk-dt7ie35vhkltqfhqewzqle62mip6tx7322pxe3nw5bza5m6sglcq-lz4-libs-1.10.0-r0.apk.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/ed/ua/brk-eduabrsb4zl6tynqrt7lx7pw2oovsx4coxr522fn6a5ov2xhtaya-binutils-cross.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/eh/df/brk-ehdf4qzwtvx2fmfp55mvisznaolv2xruotmfkmnpdrirf23ndw6a-gcc.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/eu/pe/brk-eupeaq6qg2hblz5tej56xuggi2cqkio2cwqms7jhykyeen46jq3a-gcc-cross-stage1.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/f7/6j/brk-f76j2poedi6xxjtggtc6gwzw4szxf263kj4bmfg4pk3qzeb4tzta-binutils.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/fk/5w/brk-fk5webijhkqfu6agrd7r3xby2yk3dlrrctrgdhbr3cycqqqgiurq-linux-headers.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/gh/ch/brk-ghchiozjtl2ibn4fj6cqsjqwccmgb4bjneutfqoawhgozjexoboq-python3.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/hl/6d/brk-hl6djaj44qkp6rily6m7uf6lsksicuvyiukbsphwqzo7zhddpzna-zstd-libs-1.5.6-r2.apk.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/ht/bz/brk-htbzz6bih7yozjd67du3sha2tvuaugif6hfibqqi4ype7rt22kha-bzip2-1.0.8.tar.gz.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/ic/va/brk-icva7dmsupx5ur32bcdsxt6prnjbybejewwyudymvu64ysrspepa-gcc-stage2.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/it/xg/brk-itxgxgppoxlnoqfhav4tgvdmsqhkb6xraelfh5my4ex6t6asd6jq-bzip2.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/ku/nm/brk-kunm4aanjegga2okph6bty3sklbipirbunbmraanvx2vakcuqdpa-binutils-2.44.tar.xz.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/lb/ww/brk-lbwwyryb5ltczjtxmiqa4qqhnd2igy32kvsyytdb5ycmo44ijyoq-gcc-cross-stage2.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/lj/xg/brk-ljxgs3o5vy4ctwwtmrawnn6r5gbfvqcor7loyeecc2v54wdsjp4q-popt-1.19-r4.apk.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/lk/vw/brk-lkvwp2vgtnqksd4pvrkpdnnyohghv2t4eufxpfrczxeijtowkjba-gcc-14.2.0.tar.xz.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/mh/ww/brk-mhwwjfc6yktll5jjszbt6gypcd5qkxroiz7wptwqwa72p2oiaklq-glibc-cross.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/n6/47/brk-n6475wvske6j4dxfuhhbk6gplesuoo6c3tzd2p4bk5cciypjdqna-ca-certificates.pem.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/or/nu/brk-ornuxzu76lwe2ndtm6n7andz5hgz3zxp74v362ssga4lrb7jumla-Python-3.13.13.tar.xz.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/pb/je/brk-pbjeeclqm4u6qpcwajhwup422gxqlsxugtxchb3ehilwprktypna-acl-libs-2.3.2-r1.apk.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/pp/dg/brk-ppdghkityovkxogtghygvs2mls7qza646xifdh4qt3pdr7enpi2a-coreutils.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/pw/37/brk-pw37lfr3ixpwcll66ytcwfkezsbh2smxf77zdjlx6ox6vwlifwxa-gawk.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/r2/zd/brk-r2zdfg556hdsebpb4sscmxl7y53r4bjcp3v4ux3ky6y2nzy6bs3a-glibc-2.40.tar.xz.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/r4/cz/brk-r4czt3gbzhl677qs6tbtvi4i5qkwuypq3sxstv6zgzp6xt3duq7a-linux-6.12.tar.xz.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/sl/rs/brk-slrsxagrlswbpiqjwci3lbikqk4se2iriumnycj5mzwtxmiuligq-gcc-glibc.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/te/ie/brk-teieaxxyjdoyw4gqby5r4ywgrstjp3t6ui4dxasa6j7ba34arziq-patchelf.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/tf/ag/brk-tfagkogbrwgn4fra5ytt4jabozu7lrt6jslw5pzrrauh6464cuoa-python3-glibc-3.13.13.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/to/yy/brk-toyyhmevribb7khuvecg75ctwezy43ob5us3fe232gwncayr5hkq-gpatch.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/u3/ma/brk-u3ma4d6mz2mzwbvc24lboxz2weefc3iwimxuc35srcr7gx6s56vq-linux-native-toolchain.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/vj/kf/brk-vjkfcfgkm77x6m2ulurl7euwz2rnspl5pijijlqq5wmu4fcyn6la-unzip.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/vn/mz/brk-vnmzxwbo6lnf5ihu3ck2rutyxc64jmofsabyymccsuvkz7qlasiq-bzip2-dev-1.0.8.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/vv/yh/brk-vvyhmuysr2vjsftzfyed3zekunsonl6t34mrh55zkb3mmepagjsa-diffutils.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/wd/xr/brk-wdxragmwozoaot3aj572xzixmspvwpapgofaihhvw63em7fxulxa-rsync-3.5.0-r0.apk.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/wl/uw/brk-wluwjucbrlkece4f3oq2qk6uxprq3t7h2ogids4ymiz4nsvjqmwa-xz.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/wt/mz/brk-wtmzokrljm6qieuc3vreps4ox23fng4vvkukskjrenmcmxegxh2q-libxxhash-0.8.2-r2.apk.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/x5/lb/brk-x5lbsitpqeyvvmzcpfqt4cou2m7tbpbmt5xfphiqa7zo3hckiyuq-gcc-cross.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/x6/3s/brk-x63s7v4qom7r4x7j6vg6y7p2sofdrxxj3dgw7fqdqftwwhjpixaq-perl.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/xp/q3/brk-xpq3y53udiwojwu3cmwsgbqn7pkk6y74expqaf4ss6goibdgypuq-grep.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/xt/64/brk-xt64bpkydygjzezkokdv36klu36dn4cnhm762iasa23j2g4qwyoq-gcc.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/z4/bl/brk-z4blqxd57uul4tqm55ohuj5j25og5l4a3eh5yruq7np4lfxgrpva-rsync.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/zk/if/brk-zkiff2cic77r6rxw3quhxg6gu4rznq4omwpz5tui7zwbvlqj6mbq-ld-musl.so.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/zt/bw/brk-ztbwuqmg77pfi6tzkoy4asfmpiy22x6lugzprlhhhvjldam36n4q-rubble-script-shebang.brick'

  'rubble-generated/tfagkog-python3-glibc-3.13.13/store/zy/6b/brk-zy6bvkew2exlrwyg3zjlgc47llzncsko4l6kssqxbtdjpcoe4wbq-git.brick'

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
  commit="$(rubble-exec git -C "${repo_root}" commit-tree "${tree}" -p HEAD -m "Run Rubble workflow for ${plan_id}")"
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
  export RUBBLE_PUBLISH_PLAN_ID="${plan_id}"
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