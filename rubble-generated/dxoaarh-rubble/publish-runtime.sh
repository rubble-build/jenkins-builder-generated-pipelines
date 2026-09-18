publication_dir="$(builtin cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && builtin pwd)"
# Shared local publication context and lifecycle. Sourced by a service adapter.
lifecycle_relative='lifecycle.sh'
source "${publication_dir}/${lifecycle_relative}"
target_root_relative='../..'
payload_root_relative='.'
root_brick_relative='store/dx/oa/brk-dxoaarhvjyrn52ajxwei4sxljgqcegyu4l6yqcwapr53tzwnjk6q-rubble.brick'
target_root="$(builtin cd "${publication_dir}/${target_root_relative}" && builtin pwd)"
payload_dir="$(builtin cd "${publication_dir}/${payload_root_relative}" && builtin pwd)"
root_brick="${publication_dir}/${root_brick_relative}"
user_publish_relative='../../.rubble/publish.sh'
user_publish_script="${publication_dir}/${user_publish_relative}"
root_id='dxoaarhvjyrn52ajxwei4sxljgqcegyu4l6yqcwapr53tzwnjk6q-rubble'
root_name='rubble'
pipeline_id='232e548b-0ad6-43fd-8089-385a5b2350fa'
pipeline_branch="runs/${pipeline_id}"
generated_root='rubble-generated/dxoaarh-rubble'
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

  'rubble-generated/dxoaarh-rubble/authentication.sh'

  'rubble-generated/dxoaarh-rubble/build-brick.sh'

  'rubble-generated/dxoaarh-rubble/cleanup-auth.sh'

  'rubble-generated/dxoaarh-rubble/jenkins-job-parameters.mjs'

  'rubble-generated/dxoaarh-rubble/jenkins-publish.sh'

  'rubble-generated/dxoaarh-rubble/jenkins-webhook-build.mjs'

  'rubble-generated/dxoaarh-rubble/lifecycle.sh'

  'rubble-generated/dxoaarh-rubble/publish-runtime.sh'

  'rubble-generated/dxoaarh-rubble/release-inventory.txt'

  'rubble-generated/dxoaarh-rubble/release-root.sh'

  'rubble-generated/dxoaarh-rubble/rubble-manifest-dxoaarhvjyrn52ajxwei4sxljgqcegyu4l6yqcwapr53tzwnjk6q-rubble.json'

  'rubble-generated/dxoaarh-rubble/store/26/tn/brk-26tn2yq4ryvlust5j46r2gfdg7ew7zg7gpth4bowtw5vxvj5xeiq-findutils.brick'

  'rubble-generated/dxoaarh-rubble/store/2c/r3/brk-2cr3miaqwsfbjz5dox46ivtiopgc6go2pymeqgeqlohjdercgi2q-xz-libs-5.8.3-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/2d/my/brk-2dmy2py5hdqkwaqkgx42iababq4z232di4ts36pnm5esucm3ywma-utmps-libs-0.1.2.3-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/2g/vg/brk-2gvgtrr4d2gpg5yhr2mym73arbvecrjt5uiucaqrz2y5wy5u44va-cargo-1.94.0.brick'

  'rubble-generated/dxoaarh-rubble/store/2k/he/brk-2khe7fyham7ciybnkxksiegiv56edsph55lu6pvdrik6sznbr3sa-libitm1_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/2p/kk/brk-2pkk7uybguht2x674mafoa4so6ckkoo7c5o5fx6mkcnl2ud6neia-mpc1-1.3.1-r1.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/2x/22/brk-2x22laodlqafljwyox5gwrz33zqdiz4n4hji34pewgwzpdl7doma-libstdc__-dev-14.2.0-r4.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/2z/xw/brk-2zxw44fhgjzrjfdxfy2wdkkicv2mhyh6d36apzqury43ieyngenq-linux-headers-6.6-r1.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/33/r3/brk-33r3vtwjofe5vt4rh7ovkw3tkrmk45fkwl3s4sbqp5fpobs2gdla-rubble-deps-cache.brick'

  'rubble-generated/dxoaarh-rubble/store/3b/go/brk-3bgoeaauj5s4emyhwccwfwtbft5cxf5jdpbw3cfm3cm73edir6gq-brotli-libs-1.1.0-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/3k/tt/brk-3ktt7h4cpkoe5mv4b2racn4da4dmxqy4anesjsxu65hi2matudmq-llvm-tools-1.94.0.brick'

  'rubble-generated/dxoaarh-rubble/store/3l/wx/brk-3lwxgkj4bfhbzzcj2f4ouooyvkjr2hnt4bixwahhr3jmry6lnmwq-libc6-dev_2.41-12_deb13u3_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/3r/g7/brk-3rg7zno4crltlhtuwp3k5izvvdj2c6smqkw74ebwsrfv2o6grtna-libsframe1_2.44-3_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/3s/b5/brk-3sb5itkqd6r7oxf5jlyiwmezzwtf7wd5ef5lhlzp5obo44jnr3ha-musl-dev-1.2.5-r11.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/3y/ms/brk-3ymsqx4irog2cwz3opdekqpw4otufpn5qdjdmbgzswfjrt23imbq-zstd.brick'

  'rubble-generated/dxoaarh-rubble/store/46/lf/brk-46lfnhiwl7xwedh2m5nqmsiz53zc3vcpqiox4v4mctm56nzwlz6a-bootstrap-env.brick'

  'rubble-generated/dxoaarh-rubble/store/4c/nw/brk-4cnw6f44o4vlikwytizm5k5sqix42ok6gelmtn7wuaw7gl2xic6a-bash-linux-x86_64.brick'

  'rubble-generated/dxoaarh-rubble/store/4c/og/brk-4cogqtlsttdlle5wrsmcke3em5qvfcvvir54ov3ru3elpsfnh7ja-rust-std-1.94.0-x86_64-unknown-linux-gnu.tar.xz.brick'

  'rubble-generated/dxoaarh-rubble/store/4g/vh/brk-4gvhwzfvxu2ugj4sf2jr5aq4u6pjy5jrywhkzxyimdv437sk6eba-findutils-4.10.0-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/4m/tr/brk-4mtrsm6btbhfrahkgwn4ss2s2vcmwa5frmg7ndtsnh7bjgjm2hpa-wasm-pack-v0.15.0-x86_64-unknown-linux-musl.tar.gz.brick'

  'rubble-generated/dxoaarh-rubble/store/4q/2h/brk-4q2h276sdua43q6llgpn75j67n5s66dbegpra6ilud4jwgjrb6za-rubble-web-node-modules.brick'

  'rubble-generated/dxoaarh-rubble/store/4r/gc/brk-4rgcrtd62az4jvrpnqi7mo4lmi6jkafzaizl5renuatipxrg3soa-libmpfr6_4.2.2-1_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/4w/go/brk-4wgosppvhjnle5yycvfbbhegkyo2lud5migy65e2r7cdpemghvvq-pcre2-10.43-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/4w/qt/brk-4wqtammobxoyixq6mok6psj2mp6d3pjlgjjgooaxh3pqxhhwxf2a-zlib-1.3.2-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/5c/l2/brk-5cl2d3x6sk6fpzz2vyvzamieqdptlqxbsijlye75apvhdjupzhfq-libgomp1_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/5e/ys/brk-5eyssyrncrnzjquenwd7il5bulxkll55fhs3goh2ej6gqwwuphba-RubbleR.git.partial.brick'

  'rubble-generated/dxoaarh-rubble/store/5m/mz/brk-5mmzwpdy6krzkjc3pzhzkybh4kp7bimjmrhfgk5554rnyb654agq-RubbleR.git.partial.brick'

  'rubble-generated/dxoaarh-rubble/store/5n/72/brk-5n72uhvu5cptapfmuhaql6u7gekif3s7rsavzqfspcxoyrwoybmq-curl-linux-x86_64-musl-8.18.0.tar.xz.brick'

  'rubble-generated/dxoaarh-rubble/store/5s/2g/brk-5s2guvzpcv5iov3rog7fjz2t5oa3idprxh4z7lst5ipo2mlpo2mq-binutils-x86-64-linux-gnu_2.44-3_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/6f/yi/brk-6fyi5giuhq2rktxlfg2epgwit5rqik345vr2o25yognyocmskspq-gnu-tar.brick'

  'rubble-generated/dxoaarh-rubble/store/6i/tb/brk-6itbkpqgk46i34vxf2bxe2jjugitys6463c73qfk5fhiipwku4ha-gnu-sed.brick'

  'rubble-generated/dxoaarh-rubble/store/6m/nz/brk-6mnzlup57yva4f25swep426asen4gktqclnqldiusl5pv2ejz22q-libasan8_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/6t/og/brk-6togc2j5xih6r5lrdoyn445oyyknfdytk6vcg5hrfsgc2hlgk6pq-coreutils-sha512sum-9.5-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/77/wn/brk-77wn4qjjc5t6dj7mhudt2agj5mzd6q6d4xeucta7zjc6vj44pmqq-libcurl-8.14.1-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/7b/5q/brk-7b5qkq7h725rlzwyjms32eiu6becwobfozmdtl3nmob3t75vmiuq-liblsan0_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/7b/uu/brk-7buusvdtjbv3krfq34tglkiqz2x356bf2xwow5pmosrsliurop6a-libubsan1_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/7k/og/brk-7koge3ms7mczomi4u3jid66ybbmpfrmztze7fdmsdkqzlcoojdsa-patch-2.7.6-r10.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/7k/tn/brk-7ktnbvp6fl2plw3a55esbljq2bcop6zzubnjwusospje6hknpepq-libexpat-2.8.4-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/7q/wj/brk-7qwj66t7ongdyxwj3ixwfuso2w4z75ztu277i425f66q6z76xvka-libatomic-14.2.0-r4.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/7u/mi/brk-7umiran6fdfmpi7d6wrjpaw2ezhzoksyxq4khdyf3pvexwt7sbba-unzip-6.0-r15.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/7w/bi/brk-7wbigrl6ev2wn6kywqifyd6k4krdgddinkmbhidovomli6k6bbwa-perl-5.40.4-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/7w/dy/brk-7wdydh7iziyaiskuhw2qb242fvaq4rin2kprwubf7fmvooc6iopa-git-2.47.3-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/ad/cr/brk-adcrhlud4lao22xpeqdtkmm3cbdxrk4yn7hqqh4y2wguzsupqiqq-curl.brick'

  'rubble-generated/dxoaarh-rubble/store/ap/a2/brk-apa2khzii3e7c7qnlw6krapsq77kgtc5tn5bm64uj3c2x77g5d3a-wasm-bindgen-0.2.115-x86_64-unknown-linux-musl.tar.gz.brick'

  'rubble-generated/dxoaarh-rubble/store/b2/i5/brk-b2i5h3ipeqiico2oxqfkrpcrqndt5dys43nm7qrq5hh3e5n4gqpq-libtsan2_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/b6/dq/brk-b6dqx7grj7sdvz4idoeankvdh33a6czxdhn42na3sdl2w5p2ckuq-nodejs.brick'

  'rubble-generated/dxoaarh-rubble/store/b6/du/brk-b6du7m4wvh6hhvuzjxtbgjxv3kmgap4w2jh2mjw7ztfs2mbseida-gzip.brick'

  'rubble-generated/dxoaarh-rubble/store/bf/ah/brk-bfahmy7gljzjxfst33xvrlfpvye7tavkkpozmme4kosoy3huftmq-bison-3.8.2-r1.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/bt/u4/brk-btu4wdeflhf6iv4rk4awpoj4h3ke6bdsgsdmdj6icerqhprab2zq-bison.brick'

  'rubble-generated/dxoaarh-rubble/store/bx/ch/brk-bxchorbehgapcopsqwo7w5zwjgenujywlkkytlnad3dvy5hpqc5q-bash.brick'

  'rubble-generated/dxoaarh-rubble/store/c2/7n/brk-c27nqfizbqju23t62gn5fz5at7aiszoc2jdo7rca33boiwj4rrwq-libctf0_2.44-3_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/c2/pb/brk-c2pb6bog4hbnzghhl2bdm4jrrqnq5e5oxiobkywqsl7p7igdtfva-libgcc-14-dev_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/c3/5i/brk-c35i4mn5dmhidddyvzilwvmqnvugfaai2kfuxdqlq2pknwvaciuq-libgomp-14.2.0-r4.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/c3/s5/brk-c3s55lkr27hhdooe7wnsqioryihjeapnony7fjg3czqtayimmqpa-grep-3.11-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/c5/mx/brk-c5mx6r24inu4xhdgcdtdjpfflxamue4idrmbz4koxqv6frtuwjwq-rust-std-1.94.0.brick'

  'rubble-generated/dxoaarh-rubble/store/c6/xx/brk-c6xxyv3vzmxvlpcvxl2ovsj3kswtkjuqodjgzeyznro4rzkygnba-libncursesw-6.5_p20241006-r3.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/cc/a6/brk-cca6hpdxtvtjn3hkbljrizdlu2cpldgeodds67hxlcf2nhclfc5a-m4.brick'

  'rubble-generated/dxoaarh-rubble/store/cd/gy/brk-cdgy6susoq245z4mch7qbgfzwfyqzywqchtfoveem66yiwhb4qba-gnu-make.brick'

  'rubble-generated/dxoaarh-rubble/store/ch/i5/brk-chi54kpcqcnrhdn2o5uqr5ooakyjpd5zzmpvopglrw2bcrya3txa-readline-8.2.13-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/cq/5r/brk-cq5rf2c3o57f72h3wxj4aav6a3a6dvq4jdgbq4wqj27du7n73gma-mpfr4-4.2.1-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/cz/bs/brk-czbs6vraoytel3bfaxgi2lpunsggqjavasxwzqbkr6hwtyzzdbxa-jansson-2.14-r4.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/dp/vr/brk-dpvr6zncl6lb7virjbpejxfou5xxwyxmixehunwg45vicdq5xk2a-linux-native-toolchain.brick'

  'rubble-generated/dxoaarh-rubble/store/dx/oa/brk-dxoaarhvjyrn52ajxwei4sxljgqcegyu4l6yqcwapr53tzwnjk6q-rubble.brick'

  'rubble-generated/dxoaarh-rubble/store/e3/6c/brk-e36cngjqwawgbxg2kjpzk4j2oetoiqgauw3mvvnv576ah46xmsfq-sqlite-libs-3.48.0-r4.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/ea/y2/brk-eay2yd76jtq2n72kafauwkofupanezwq2muobm7bjlf6mfojk4ma-linux-libc-dev_6.12.86-1_all.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/el/5x/brk-el5x6jtrgmj2ur2yrzw322uhsjmbhn5yrocuvgpacoemkg64pvnq-coreutils-fmt-9.5-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/eo/66/brk-eo66u6nzusdktuggisxpvr7qmzxvwr4lxwlclvsre4irq6krhcoq-libstdc__6_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/eo/ps/brk-eopsbz4ia2xmktldjshfv6bferpwxnexagroon63m4ryp3nu6lgq-wasm-bindgen-cli-0.2.115.brick'

  'rubble-generated/dxoaarh-rubble/store/ev/ty/brk-evtymdmzbmwvbqahpv3jn3fct73m5qstjmh54f2o7msjks7krita-gcc-14-x86-64-linux-gnu_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/fx/dl/brk-fxdlr54bss5xchltnftplbazx75gkxrblhjswghx525wntx4z47q-binaryen-version_117-x86_64-linux.tar.gz.brick'

  'rubble-generated/dxoaarh-rubble/store/fy/jv/brk-fyjvlznpum5cwh7apldb3sv4skrbahxa5uekyqo2eqwrcm2tzuxq-libatomic1_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/g5/kw/brk-g5kws3kqcm624hn6iai7emgexyefsmvzne6vkkjepjynecaixwka-libattr-2.5.2-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/ge/q2/brk-geq2hsuhuzr6soywtb5evjghfoflwtikb5fax6dw5rm4y5p4b6pa-bun-linux-x64.zip.brick'

  'rubble-generated/dxoaarh-rubble/store/gh/ch/brk-ghchiozjtl2ibn4fj6cqsjqwccmgb4bjneutfqoawhgozjexoboq-python3.brick'

  'rubble-generated/dxoaarh-rubble/store/gn/35/brk-gn35dmjju7ixfllbazzkcjuoxfqy5sbsv6g6ghmtlkm5boylcb2a-zstd-1.5.6-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/gn/h4/brk-gnh47phed75uwi3vbxi5scokhxo64p5gcafwkkjx6oowdevwnhga-c-ares-1.34.8-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/gn/ns/brk-gnnsnnf6yelk7gnriytilbxswxoiys2ynfurvdpenuuj3ynneg4q-libffi-3.4.7-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/gn/sd/brk-gnsdsnsfgkb2hv2pa3ejhm3rrxa65ls7pz6v7cbyj6uuwncqnqfa-sed-4.9-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/he/cn/brk-hecnfft6yktxoi7yeh4xxz4unpght7p5ya35dtsbntdhaebpbqaq-rustc-1.94.0.brick'

  'rubble-generated/dxoaarh-rubble/store/hl/6d/brk-hl6djaj44qkp6rily6m7uf6lsksicuvyiukbsphwqzo7zhddpzna-zstd-libs-1.5.6-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/hq/js/brk-hqjsomgsdf5yekubrqawdyfsvgwq3qx3uesyfpggo4ogd5ohak4q-isl26-0.26-r1.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/hs/eq/brk-hseqkp4htbof2oy5ft32zmuk6nrjwse7qhf2e7nlyfrrphs3sc5a-wasm-pack-0.15.0.brick'

  'rubble-generated/dxoaarh-rubble/store/hs/yi/brk-hsyi55wlvnlzocc3t5nac44lqr62jzqndxhhgwdvwju3vshv6zla-llvm-tools-1.94.0-x86_64-unknown-linux-gnu.tar.xz.brick'

  'rubble-generated/dxoaarh-rubble/store/hy/7v/brk-hy7vvf7hx76tdededuy6vbt2zjw2rzd2papv6r7qm2m52vhchfna-libzstd1_1.5.7_dfsg-1_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/ih/kb/brk-ihkb436hgrr2ikz2jd4v5enxpqhklppqp6s5usbutl4q6fqxs3ja-g__-14-x86-64-linux-gnu_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/im/ju/brk-imjuc3so77aavqsehwiata3ic2jj4aigpbd2phqujrpry5wlmika-gawk-5.3.1-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/iq/ru/brk-iqruyywvdmkzsmzzmu7rmrnp6fqgg7e2na76j3ty3skevyvcbu4q-libquadmath0_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/it/xg/brk-itxgxgppoxlnoqfhav4tgvdmsqhkb6xraelfh5my4ex6t6asd6jq-bzip2.brick'

  'rubble-generated/dxoaarh-rubble/store/iv/lv/brk-ivlvi6gy2ft3ha4xhyhznjq4ddnj2gje7icw3knjcb73ltiwrfqq-libbz2-1.0.8-r6.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/iy/jy/brk-iyjypwircokg6krpk3iuqjdqbet3joqufbfsylg5mnjav52ljpua-rust-web-wasm-toolchain.brick'

  'rubble-generated/dxoaarh-rubble/store/jn/mg/brk-jnmg45vg4ddydtuugrzlidkaux7kjxduijdqlfs3fgcoewkrrnfa-gcc-14.2.0-r4.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/jp/4n/brk-jp4nke5sdzqmyvapf2eldbwlmy5cbvjyapsqjlluunq3cuddjciq-nodejs-runtime.brick'

  'rubble-generated/dxoaarh-rubble/store/ki/nr/brk-kinr2ibs6py4vcjwsdsh6fawg2nbzzyj6vptydryyosyxaijodeq-ca-certificates-bundle-20260413-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/l2/4q/brk-l24qwy42aqiewm3ebjhacljc76ulo4vdrxgfyizlt2oztxqco5jq-mpdecimal-4.0.0-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/lb/ql/brk-lbqljp2qnjc3lqq3z4cfzjji23m4ifkssgngl2fjn4ko44ymiyoa-coreutils-env-9.5-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/lk/dc/brk-lkdcyamlgiacwnr5imp3lw4ieiybrpiqccyf5sxnatnjwd5b3mqa-skalibs-libs-2.14.3.0-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/lu/y4/brk-luy4bjnugq4iyxf653mduencnzaptaunhu4mph7pdata3houha5q-binutils-common_2.44-3_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/mc/6q/brk-mc6qyizfse757jxx72bss56cw6jyea2jff3xggbcm2feis7oedta-RubbleR.git.partial.brick'

  'rubble-generated/dxoaarh-rubble/store/mi/6o/brk-mi6ohmutnclicttozbnjjmgo5r6nutdophs5rgp6kru2gg7tqxqq-libunistring-1.2-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/ml/6k/brk-ml6kgq7lqo3ixjammk6mzn4rikciq3cz72gvsczixoig3lafebua-coreutils-9.5-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/mq/ul/brk-mqul3nsqce7mp3txaf3mw5vmtgpw7c2glfkqaugdgeuqsrmrgrgq-RubbleR.git.partial.brick'

  'rubble-generated/dxoaarh-rubble/store/n6/47/brk-n6475wvske6j4dxfuhhbk6gplesuoo6c3tzd2p4bk5cciypjdqna-ca-certificates.pem.brick'

  'rubble-generated/dxoaarh-rubble/store/ng/fm/brk-ngfmqg7sdtevod5fupkehkz7ngg7lb4zc6hfheixgvduoprmea4a-libjansson4_2.14-2_b3_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/nw/ad/brk-nwadxrnuk7cydd6sigwmkqkyyxpkgj3b7bfoyhol66daeqo4rfka-rust-std-1.94.0-wasm32-unknown-unknown.tar.xz.brick'

  'rubble-generated/dxoaarh-rubble/store/oj/uc/brk-ojuca6brtedwpgh2rphrf3th52tfvbpqkqqnddtxowcmsxy3u2mq-python3-3.12.14-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/on/lk/brk-onlk2zatshrcc5wdjmkfvypvk27d3g5b3yw5p2bxwlfzdfjcyndq-libpanelw-6.5_p20241006-r3.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/op/mf/brk-opmf3fnkrx63nigobxuvurfjeg772qcva6agm646urua5asfsc6a-make-4.4.1-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/oq/oa/brk-oqoaxy5m5bddhssgfc7jhe5q7mna2ydylmq75vxuvraqx2tqk2ca-libcrypto3-3.3.7-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/p3/5f/brk-p35fui5viqtrg47hzy5wwvgkewwbtgsqytapgqav4jzy4w5vud4a-rustc-1.94.0-x86_64-unknown-linux-gnu.tar.xz.brick'

  'rubble-generated/dxoaarh-rubble/store/p5/uk/brk-p5uktxyamskabu2gk3grichqlqinop3payt7ptqw6d4srcvsaz5a-libstdc__-14-dev_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/p6/4u/brk-p64ubkpmkkadsqqhidffg25atg2wgfinaacychgsfyt3outqqtdq-libc6_2.41-12_deb13u3_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/pb/je/brk-pbjeeclqm4u6qpcwajhwup422gxqlsxugtxchb3ehilwprktypna-acl-libs-2.3.2-r1.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/pk/tw/brk-pktwewtwfe5eg3k5tr4cbfakejnkwk4vmnxyqfb3zkwum2rxpxfq-glibc-runtime-support.brick'

  'rubble-generated/dxoaarh-rubble/store/po/yq/brk-poyqkgpnrlor4i3embihirbnvv2lkaoat3pg55lbgvgmj2l4rlfa-gmp-6.3.0-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/pp/5m/brk-pp5mdkq27cweyfk3tmnimt5y23i2qdjbjhlhx2bia6a67iyjm7ya-diffutils-3.10-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/pp/dg/brk-ppdghkityovkxogtghygvs2mls7qza646xifdh4qt3pdr7enpi2a-coreutils.brick'

  'rubble-generated/dxoaarh-rubble/store/pw/37/brk-pw37lfr3ixpwcll66ytcwfkezsbh2smxf77zdjlx6ox6vwlifwxa-gawk.brick'

  'rubble-generated/dxoaarh-rubble/store/q4/6x/brk-q46xa2esxah2zsx3zxp2fbmxzvp4kvdon67kd5nvccztzpn6kiia-rubble-web-assets.brick'

  'rubble-generated/dxoaarh-rubble/store/qa/hc/brk-qahczze2w5oyaxj5ledbeizlod4hco54ydowp6zvk4wryzwpqu2q-libidn2-2.3.7-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/qc/y4/brk-qcy4v2y3ag67kk2t4lcxynj7ggg3bgwitfras34m4a4losfnw7ha-rust-toolchain.brick'

  'rubble-generated/dxoaarh-rubble/store/qx/tw/brk-qxtwnblp3d674vhhwxi33gd4hka5nzyis4krgtapmfnkjs7572yq-cargo-1.94.0-x86_64-unknown-linux-gnu.tar.xz.brick'

  'rubble-generated/dxoaarh-rubble/store/r2/rl/brk-r2rl2pbw7edcma3xcpjbnfmj5xa2l5ltff3xr3tyxxpfej5udu5a-libbinutils_2.44-3_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/ri/ue/brk-riuewubniwiboir5fq3jjufegmdvpfusk2fp25gcllfzgwstcwfa-nghttp2-libs-1.69.0-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/rp/xr/brk-rpxr23txqir7gm3jeg34or6v3x33tk66wsicortn5nabw7pgv4za-musl-1.2.5-r11.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/rr/24/brk-rr24d5jtgkkrifatmbdolj2lttqqu6g5h35w3qe536jpenad2e6q-cpp-14-x86-64-linux-gnu_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/rt/jd/brk-rtjdny3tqwczthrggwpu26g2ifmdo6v7aleojn6g2qmimnohtx2a-tar-1.35-r2.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/ry/7d/brk-ry7dxugonx43nz5l7zqafhnyf7g44osnmhejuhlt4x3bhh6x4lya-libgmp10_6.3.0_dfsg-3_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/ry/jw/brk-ryjwb6a3ynqdajbncvpdzwephlmhpxe56zvtgfs4cv4x5lvdguca-rubble-src-checkout.brick'

  'rubble-generated/dxoaarh-rubble/store/sc/of/brk-scofokclgi3ex4hzrtnmlf6lpkcpmii52orptjcupfmikihi6kxq-zlib1g_1.3.dfsg_really1.3.1-1_b1_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/sh/id/brk-shidbibgptsswa33nbpjwlsxa3kcz7mxtobh33lkji6l2bz7pgka-bun-1.4.2.brick'

  'rubble-generated/dxoaarh-rubble/store/sm/gl/brk-smglbxy2qltuw55ubbydcyhowlyzyzpmmwhii6rttwdgrcn6yhwa-libisl23_0.27-1_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/so/yq/brk-soyqxtymcfjf74xui3ydngvt6so3orqonn4dzhh2gpwgcp2q6gna-libhwasan0_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/sr/ku/brk-srku7z24wv4w4tgv6eu4fa6qbu5agbdkyenupgctdee7bxpivfaq-patchelf-0.18.0-x86_64.tar.gz.brick'

  'rubble-generated/dxoaarh-rubble/store/t6/xq/brk-t6xqfwfwlrrilozolb4u3zqjqyvl4ak7wbq5j6hxpicb3ycidfpa-libpsl-0.21.5-r3.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/te/ie/brk-teieaxxyjdoyw4gqby5r4ywgrstjp3t6ui4dxasa6j7ba34arziq-patchelf.brick'

  'rubble-generated/dxoaarh-rubble/store/to/yy/brk-toyyhmevribb7khuvecg75ctwezy43ob5us3fe232gwncayr5hkq-gpatch.brick'

  'rubble-generated/dxoaarh-rubble/store/tv/ix/brk-tvixmybabsgwepyqt72yuhquuoeqcckd2i27zucfmmuz4af4byxa-rubble-elf-runtime.brick'

  'rubble-generated/dxoaarh-rubble/store/tx/b6/brk-txb64vqfae7aa5nhycodgois76zpayaio6xopelsmuan5mnhhzzq-libcc1-0_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/un/m7/brk-unm7rdbhcinb6zy5gv5mtbcxj5eyjpugs7ve5lhnp7jj6wmewpxq-RubbleR.git.brick'

  'rubble-generated/dxoaarh-rubble/store/un/xl/brk-unxlmwftoohd5ub6hgpvylolxd6zjczt462o5jf6zyb2nmexflpa-gcc-14-base_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/up/on/brk-uponfvj6pefnvsurlqpyw22eznhrunf2cw2p5uu46wzoydakpceq-gcc-glibc.brick'

  'rubble-generated/dxoaarh-rubble/store/vj/kf/brk-vjkfcfgkm77x6m2ulurl7euwz2rnspl5pijijlqq5wmu4fcyn6la-unzip.brick'

  'rubble-generated/dxoaarh-rubble/store/vt/a6/brk-vta6yl5kfo7l43xvgauwa32n5mdi7kx7vjxjymz4odjpnhxy2gfa-gzip-1.13-r1.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/vv/yh/brk-vvyhmuysr2vjsftzfyed3zekunsonl6t34mrh55zkb3mmepagjsa-diffutils.brick'

  'rubble-generated/dxoaarh-rubble/store/w2/nv/brk-w2nvclvz4n67yxhsuoio5kwv6aihl4fwjeeqdbjgqpmnauv7sfxa-g__-14.2.0-r4.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/w3/4r/brk-w34r6xbrp5naxtwy4i2yjuqgwtocs272gmp3wpl6jzg7tchrtjra-libgcc-s1_14.2.0-19_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/w7/gt/brk-w7gterx6tkmti6wv733mqag4engf5xzrpvyrazpfjb7u7cvs7hla-node-v22.22.3-linux-x64.tar.xz.brick'

  'rubble-generated/dxoaarh-rubble/store/wd/o3/brk-wdo34y7tme4bosf2fda6yjm7eqqsvedws6mqugeq2ixcennl3ikq-libssl3-3.3.7-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/wl/uw/brk-wluwjucbrlkece4f3oq2qk6uxprq3t7h2ogids4ymiz4nsvjqmwa-xz.brick'

  'rubble-generated/dxoaarh-rubble/store/wo/6v/brk-wo6vgn55jsmxeqnkavm4rcompkku3ssc2xyxdc4nrbbcx5ggc2ea-libmpc3_1.3.1-1_b3_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/wo/rm/brk-worm5jasvkdhvnlzzohf5oauc7lqf6dvcl63d5owgyl3cxnyq2ka-m4-1.4.19-r3.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/x6/3s/brk-x63s7v4qom7r4x7j6vg6y7p2sofdrxxj3dgw7fqdqftwwhjpixaq-perl.brick'

  'rubble-generated/dxoaarh-rubble/store/xp/q3/brk-xpq3y53udiwojwu3cmwsgbqn7pkk6y74expqaf4ss6goibdgypuq-grep.brick'

  'rubble-generated/dxoaarh-rubble/store/xp/su/brk-xpsu7cfnztrrwbvvhovnnlzvjzp3f6qf6funj7ehcobaqgpnx6ha-rubble-canonical-script.brick'

  'rubble-generated/dxoaarh-rubble/store/xt/64/brk-xt64bpkydygjzezkokdv36klu36dn4cnhm762iasa23j2g4qwyoq-gcc.brick'

  'rubble-generated/dxoaarh-rubble/store/y2/gc/brk-y2gczfciw3klma4mkheml5yh6gpkn4mnakp5qr5vsjygqqy33paa-libctf-nobfd0_2.44-3_amd64.deb.brick'

  'rubble-generated/dxoaarh-rubble/store/y5/wl/brk-y5wlnu6yes4le6p335gxl52cnwerqwljbxo7micl3flp45e2q63a-gdbm-1.24-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/y6/6x/brk-y66xqjdfnmyt3m5hsbute7ucmeumlkm2bwhhlqp6is663jgjcx6a-xz-5.8.3-r0.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/ya/we/brk-yawesszimcd2qlnyer7jhtzq53jkzoadt5yxtoqgqjfmirmyrccq-libstdc__-14.2.0-r4.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/ye/no/brk-yenozywg5j7rikyirqweffk37of6kzkge34hwfauoczphjloixoq-bzip2-1.0.8-r6.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/yg/iy/brk-ygiy7hr5xdujt354tflhamaynd7pulonibb4exgkrqfb6eyq3ova-libgcc-14.2.0-r4.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/yz/2g/brk-yz2gkzppzklqwxcexejnusirhckaj5q3znbfvnvabxdkbrjrduaq-binaryen-117.brick'

  'rubble-generated/dxoaarh-rubble/store/zf/y6/brk-zfy67agwxmyoiii7ufxqtoila6o65ig2u3aqqjo72h2snsjskhja-binutils-2.43.1-r3.apk.brick'

  'rubble-generated/dxoaarh-rubble/store/zk/if/brk-zkiff2cic77r6rxw3quhxg6gu4rznq4omwpz5tui7zwbvlqj6mbq-ld-musl.so.brick'

  'rubble-generated/dxoaarh-rubble/store/zt/bw/brk-ztbwuqmg77pfi6tzkoy4asfmpiy22x6lugzprlhhhvjldam36n4q-rubble-script-shebang.brick'

  'rubble-generated/dxoaarh-rubble/store/zu/ju/brk-zujuie37eo76vyfvxqs2lv5qwcndgjrdeatxuclyaviywufxfiea-rust-std-1.94.0-wasm32-unknown-unknown.brick'

  'rubble-generated/dxoaarh-rubble/store/zy/6b/brk-zy6bvkew2exlrwyg3zjlgc47llzncsko4l6kssqxbtdjpcoe4wbq-git.brick'

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