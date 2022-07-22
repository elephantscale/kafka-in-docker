#!/bin/bash

# set CURRENT_USER if not set
export CURRENT_USER="${CURRENT_USER-$(id -u):$(id -g)}"
# echo $CURRENT_USER

# make maven build dir, if doesn't exist
mkdir -p  $HOME/.m2

# just in case 
docker network create bobafett-net 2> /dev/null

docker run -it --rm \
    --user $CURRENT_USER \
    --network  bobafett-net \
    --hostname kakfa-dev \
    -v $HOME/.m2:/var/maven/.m2  \
    -v $(pwd):/workspace:z   \
    -w /workspace \
    elephantscale/kafka-dev

