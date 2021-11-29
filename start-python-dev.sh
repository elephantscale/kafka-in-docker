#!/bin/bash

# we need this so docker-compose can start the container as current user
export CURRENT_USER="$(id -u):$(id -g)"
# echo $CURRENT_USER

# build kafka-pydev
# (cd python-dev ;  docker build . -t kafka-pydev)

docker run -it --rm \
    --user $CURRENT_USER \
    --network  kafka-net \
    -v $(pwd)/work:/work:z   \
    -w /work \
    kafka-pydev  \
    /bin/bash