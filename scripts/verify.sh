#!/usr/bin/env bash

set -eo pipefail

dapp verify-contract src/ChainLog.sol:ChainLog 0x00e600FE55158BD1426De123d0E49C69b0a03156
