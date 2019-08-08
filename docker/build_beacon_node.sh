#!/bin/bash

set -euv

cd $(dirname "$0")

export GIT_REVISION=$(git rev-parse HEAD)

NETWORK=testnet1

if [[ $(git rev-parse --abbrev-ref HEAD) == "master" ]]; then
  NETWORK=testnet0
fi

buildAndPush() {
  export NETWORK=$1
  export NETWORK_TYPE=$2

  (cd beacon_node && make push)
}

# buildAndPush $NETWORK rlpx
buildAndPush $NETWORK libp2p

