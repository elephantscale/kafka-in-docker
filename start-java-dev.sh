#!/bin/bash

# we need this so docker-compose can start the container as current user
export CURRENT_USER="$(id -u):$(id -g)"
# echo $CURRENT_USER

docker-compose run java-dev
