#!/usr/bin/env bash

set -eo pipefail

deployer=0x0f14341A7f464320319025540E8Fe48Ad0fe5aec
chainlog=0x000000000774019b96f067cda9fE26076649c729

dapp verify-contract src/ChainLog.sol:ChainLog $chainlog $deployer
