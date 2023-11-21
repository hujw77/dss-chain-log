#!/usr/bin/env bash

set -eo pipefail

convert() {
  seth --to-bytes32 $(seth --from-ascii "${1:?}")
}

CHANGELOG=0x000000000774019b96f067cda9fE26076649c729

# seth send $CHANGELOG "setVersion(string)" '"1.0.0"'
# seth send $CHANGELOG "setAddress(bytes32,address)" $(convert "CHANGELOG") $CHANGELOG

path=$(dirname $0)/conf/addr.json
keys=$(jq -r 'keys_unsorted[]' $path)
for k in $keys; do
  v=$(jq -r ".${k}" $path)
  seth send $CHANGELOG "setAddress(bytes32,address)" $(convert "$k") $v
done
