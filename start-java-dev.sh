#!/bin/bash

# we need this so docker-compose can start the container as current user
export CURRENT_USER="$(id -u):$(id -g)"
# echo $CURRENT_USER

# make maven build dir, if doesn't exist
mkdir -p  $HOME/.m2

docker run -it --rm \
    --user $CURRENT_USER \
    -v $HOME/.m2:/var/maven/.m2  \
    -v $(pwd)/config/maven/settings.xml:/usr/share/maven/conf/settings.xml:ro   \
    -v $(pwd)/work:/work:z   \
    -w /work \
    maven:3-jdk-11  \
    /bin/bash

