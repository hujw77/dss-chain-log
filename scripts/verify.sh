#!/usr/bin/env bash

set -eo pipefail

deployer=0x0f14341A7f464320319025540E8Fe48Ad0fe5aec
chainlog=0x00e600FE55158BD1426De123d0E49C69b0a03156

dapp verify-contract src/ChainLog.sol:ChainLog $chainlog $deployer
