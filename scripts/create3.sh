#!/usr/bin/env bash

set -eo pipefail

toLower() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

chain=$1
addr=0x00e600FE55158BD1426De123d0E49C69b0a03156
salt=0x096908ca6f35948329eb87af04a92f8426128c224e5cb8b32d1340c40dcbc019
c3=0x0000000000C76fe1798a428F60b27c6724e03408
deployer=0x0f14341A7f464320319025540E8Fe48Ad0fe5aec

bytecode=$(jq -r ".contracts[\"src/ChainLog.sol\"].ChainLog.evm.bytecode.object" out/dapp.sol.json)
args=$(ethabi encode params -v address ${deployer:2})
creationCode=0x$bytecode$args
# salt, creationCode
expect_addr=$(seth call $c3 "deploy(bytes32,bytes)(address)" $salt $creationCode --chain $chain)

set -x

if [[ $(toLower "${addr}") == $(toLower "${expect_addr}") ]]; then
  seth send $c3 "deploy(bytes32,bytes)" $salt $creationCode --chain $chain
else
  echo "Unexpected address."
fi
