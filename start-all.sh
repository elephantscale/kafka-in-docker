#!/bin/bash

export CURRENT_USER="$(id -u):$(id -g)"
# echo $CURRENT_USER

docker-compose up -d