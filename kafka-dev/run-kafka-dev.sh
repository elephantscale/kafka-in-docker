#!/bin/bash

# set CURRENT_USER if not set
export CURRENT_USER="${CURRENT_USER-$(id -u):$(id -g)}"
# echo $CURRENT_USER

# make maven build dir, if doesn't exist
mkdir -p  $HOME/.m2

docker run -it --rm \
    --user $CURRENT_USER \
    --network  bobafett-net \
    -v $HOME/.m2:/var/maven/.m2  \
    -v $(pwd):/workspace:z   \
    -w /workspace \
    elephantscale/kafka-dev

