#!/usr/bin/env bash

set -eo pipefail

toLower() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

chain=$1
addr=0x000000000774019b96f067cda9fE26076649c729
salt=0xc9572b9ae0a5db721e107e50b1ad6155ec84de79dc00302f2e0a77f2bd5b450c
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
