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

  'store/hl/6d/brk-hl6djaj44qkp6rily6m7uf6lsksicuvyiukbsphwqzo7zhddpzna-zstd-libs-1.5.6-r2.apk.brick'

  'store/cm/5l/brk-cm5le2xhmapvc7ocadlvrx3k7n7bf35nr6rodwvc5fktgx62urkq-zlib-1.3.2.tar.gz.brick'

  'store/4w/qt/brk-4wqtammobxoyixq6mok6psj2mp6d3pjlgjjgooaxh3pqxhhwxf2a-zlib-1.3.2-r0.apk.brick'

  'store/zt/bw/brk-ztbwuqmg77pfi6tzkoy4asfmpiy22x6lugzprlhhhvjldam36n4q-rubble-script-shebang.brick'

  'store/wd/xr/brk-wdxragmwozoaot3aj572xzixmspvwpapgofaihhvw63em7fxulxa-rsync-3.5.0-r0.apk.brick'

  'store/lj/xg/brk-ljxgs3o5vy4ctwwtmrawnn6r5gbfvqcor7loyeecc2v54wdsjp4q-popt-1.19-r4.apk.brick'

  'store/te/ie/brk-teieaxxyjdoyw4gqby5r4ywgrstjp3t6ui4dxasa6j7ba34arziq-patchelf.brick'

  'store/6f/kb/brk-6fkbbg6pc4yfhgvgo5pvqnh3447niza2cjqxt27aibzytwyzdj7a-mpfr-4.1.0.tar.bz2.brick'

  'store/2g/nn/brk-2gnnygccogetfxv3mfq5wrsghkq4swdc45zuyny7q3jyhq5xwe3a-mpc-1.2.1.tar.gz.brick'

  'store/dt/7i/brk-dt7ie35vhkltqfhqewzqle62mip6tx7322pxe3nw5bza5m6sglcq-lz4-libs-1.10.0-r0.apk.brick'

  'store/r4/cz/brk-r4czt3gbzhl677qs6tbtvi4i5qkwuypq3sxstv6zgzp6xt3duq7a-linux-6.12.tar.xz.brick'

  'store/wt/mz/brk-wtmzokrljm6qieuc3vreps4ox23fng4vvkukskjrenmcmxegxh2q-libxxhash-0.8.2-r2.apk.brick'

  'store/zk/if/brk-zkiff2cic77r6rxw3quhxg6gu4rznq4omwpz5tui7zwbvlqj6mbq-ld-musl.so.brick'

  'store/3y/ms/brk-3ymsqx4irog2cwz3opdekqpw4otufpn5qdjdmbgzswfjrt23imbq-zstd.brick'

  'store/wl/uw/brk-wluwjucbrlkece4f3oq2qk6uxprq3t7h2ogids4ymiz4nsvjqmwa-xz.brick'

  'store/vj/kf/brk-vjkfcfgkm77x6m2ulurl7euwz2rnspl5pijijlqq5wmu4fcyn6la-unzip.brick'

  'store/cc/a6/brk-cca6hpdxtvtjn3hkbljrizdlu2cpldgeodds67hxlcf2nhclfc5a-m4.brick'

  'store/6q/yw/brk-6qywaqu63vt3ydbo74p2fqxifkn77izwg5amobej6nca3oao2xla-isl-0.24.tar.bz2.brick'

  'store/b6/du/brk-b6du7m4wvh6hhvuzjxtbgjxv3kmgap4w2jh2mjw7ztfs2mbseida-gzip.brick'

  'store/xp/q3/brk-xpq3y53udiwojwu3cmwsgbqn7pkk6y74expqaf4ss6goibdgypuq-grep.brick'

  'store/to/yy/brk-toyyhmevribb7khuvecg75ctwezy43ob5us3fe232gwncayr5hkq-gpatch.brick'

  'store/6i/tb/brk-6itbkpqgk46i34vxf2bxe2jjugitys6463c73qfk5fhiipwku4ha-gnu-sed.brick'

  'store/cd/gy/brk-cdgy6susoq245z4mch7qbgfzwfyqzywqchtfoveem66yiwhb4qba-gnu-make.brick'

  'store/ap/wv/brk-apwv2emy6cpgfjhifot4on26vbuiigqxu2nabpoyf42xknawsowa-gmp-6.2.1.tar.bz2.brick'

  'store/r2/zd/brk-r2zdfg556hdsebpb4sscmxl7y53r4bjcp3v4ux3ky6y2nzy6bs3a-glibc-2.40.tar.xz.brick'

  'store/lk/vw/brk-lkvwp2vgtnqksd4pvrkpdnnyohghv2t4eufxpfrczxeijtowkjba-gcc-14.2.0.tar.xz.brick'

  'store/pw/37/brk-pw37lfr3ixpwcll66ytcwfkezsbh2smxf77zdjlx6ox6vwlifwxa-gawk.brick'

  'store/26/tn/brk-26tn2yq4ryvlust5j46r2gfdg7ew7zg7gpth4bowtw5vxvj5xeiq-findutils.brick'

  'store/vv/yh/brk-vvyhmuysr2vjsftzfyed3zekunsonl6t34mrh55zkb3mmepagjsa-diffutils.brick'

  'store/ad/cr/brk-adcrhlud4lao22xpeqdtkmm3cbdxrk4yn7hqqh4y2wguzsupqiqq-curl.brick'

  'store/n6/47/brk-n6475wvske6j4dxfuhhbk6gplesuoo6c3tzd2p4bk5cciypjdqna-ca-certificates.pem.brick'

  'store/ht/bz/brk-htbzz6bih7yozjd67du3sha2tvuaugif6hfibqqi4ype7rt22kha-bzip2-1.0.8.tar.gz.brick'

  'store/it/xg/brk-itxgxgppoxlnoqfhav4tgvdmsqhkb6xraelfh5my4ex6t6asd6jq-bzip2.brick'

  'store/ku/nm/brk-kunm4aanjegga2okph6bty3sklbipirbunbmraanvx2vakcuqdpa-binutils-2.44.tar.xz.brick'

  'store/bx/ch/brk-bxchorbehgapcopsqwo7w5zwjgenujywlkkytlnad3dvy5hpqc5q-bash.brick'

  'store/x6/3s/brk-x63s7v4qom7r4x7j6vg6y7p2sofdrxxj3dgw7fqdqftwwhjpixaq-perl.brick'

  'store/zy/6b/brk-zy6bvkew2exlrwyg3zjlgc47llzncsko4l6kssqxbtdjpcoe4wbq-git.brick'

  'store/xt/64/brk-xt64bpkydygjzezkokdv36klu36dn4cnhm762iasa23j2g4qwyoq-gcc.brick'

  'store/bt/u4/brk-btu4wdeflhf6iv4rk4awpoj4h3ke6bdsgsdmdj6icerqhprab2zq-bison.brick'

  'store/pb/je/brk-pbjeeclqm4u6qpcwajhwup422gxqlsxugtxchb3ehilwprktypna-acl-libs-2.3.2-r1.apk.brick'

  'store/z4/bl/brk-z4blqxd57uul4tqm55ohuj5j25og5l4a3eh5yruq7np4lfxgrpva-rsync.brick'

  'store/6f/yi/brk-6fyi5giuhq2rktxlfg2epgwit5rqik345vr2o25yognyocmskspq-gnu-tar.brick'

  'store/pp/dg/brk-ppdghkityovkxogtghygvs2mls7qza646xifdh4qt3pdr7enpi2a-coreutils.brick'

  'store/gh/ch/brk-ghchiozjtl2ibn4fj6cqsjqwccmgb4bjneutfqoawhgozjexoboq-python3.brick'

  'store/46/lf/brk-46lfnhiwl7xwedh2m5nqmsiz53zc3vcpqiox4v4mctm56nzwlz6a-bootstrap-env.brick'

  'store/fk/5w/brk-fk5webijhkqfu6agrd7r3xby2yk3dlrrctrgdhbr3cycqqqgiurq-linux-headers.brick'

  'store/5a/px/brk-5apxix5e5vnkwoe4owil4q6x64de3qdxlialv3vbeibr6pzhxada-bootstrap-build-tools.brick'

  'store/ed/ua/brk-eduabrsb4zl6tynqrt7lx7pw2oovsx4coxr522fn6a5ov2xhtaya-binutils-cross.brick'

  'store/eu/pe/brk-eupeaq6qg2hblz5tej56xuggi2cqkio2cwqms7jhykyeen46jq3a-gcc-cross-stage1.brick'

  'store/6p/4c/brk-6p4ctsz2fw6i3hw3toxuwyxyzrwpcuouxzy5dez6yxyv4uivhxzq-glibc-headers.brick'

  'store/lb/ww/brk-lbwwyryb5ltczjtxmiqa4qqhnd2igy32kvsyytdb5ycmo44ijyoq-gcc-cross-stage2.brick'

  'store/mh/ww/brk-mhwwjfc6yktll5jjszbt6gypcd5qkxroiz7wptwqwa72p2oiaklq-glibc-cross.brick'

  'store/x5/lb/brk-x5lbsitpqeyvvmzcpfqt4cou2m7tbpbmt5xfphiqa7zo3hckiyuq-gcc-cross.brick'

  'store/f7/6j/brk-f76j2poedi6xxjtggtc6gwzw4szxf263kj4bmfg4pk3qzeb4tzta-binutils.brick'

  'store/eh/df/brk-ehdf4qzwtvx2fmfp55mvisznaolv2xruotmfkmnpdrirf23ndw6a-gcc.brick'

  'store/ic/va/brk-icva7dmsupx5ur32bcdsxt6prnjbybejewwyudymvu64ysrspepa-gcc-stage2.brick'

  'store/7x/yx/brk-7xyxj2gbjwpxtezphrdodjfdexxgf7edctmubyozr5rbvwz6yjqq-glibc-native.brick'

  'store/sl/rs/brk-slrsxagrlswbpiqjwci3lbikqk4se2iriumnycj5mzwtxmiuligq-gcc-glibc.brick'

  'store/u3/ma/brk-u3ma4d6mz2mzwbvc24lboxz2weefc3iwimxuc35srcr7gx6s56vq-linux-native-toolchain.brick'

  'store/vn/mz/brk-vnmzxwbo6lnf5ihu3ck2rutyxc64jmofsabyymccsuvkz7qlasiq-bzip2-dev-1.0.8.brick'

  'store/or/nu/brk-ornuxzu76lwe2ndtm6n7andz5hgz3zxp74v362ssga4lrb7jumla-Python-3.13.13.tar.xz.brick'

  'store/tf/ag/brk-tfagkogbrwgn4fra5ytt4jabozu7lrt6jslw5pzrrauh6464cuoa-python3-glibc-3.13.13.brick'

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