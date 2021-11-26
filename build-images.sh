#!/bin/bash

# build kafka manager
docker-compose -f docker-compose-single-kafka.yml build

# build kafka-pydev
(cd python-dev ;  docker build . -t kafka-pydev)