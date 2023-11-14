all        :; DAPP_BUILD_OPTIMIZE=1 DAPP_BUILD_OPTIMIZE_RUNS=200 dapp --use solc:0.6.12 build
clean      :; dapp clean
test       :; DAPP_BUILD_OPTIMIZE=1 DAPP_BUILD_OPTIMIZE_RUNS=200 dapp --use solc:0.6.12 test -v
deploy     :; @./scripts/create3.sh $(chain)
verify     :; @./scripts/verify.sh
list       :; @./scripts/keys2ascii.sh
chainlog   :; @./scripts/chainlog.sh $(entry)
