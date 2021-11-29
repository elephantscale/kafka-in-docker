#!/bin/bash

# build kafka manager
docker-compose -f docker-compose-kafka-single.yml build

# build kafka-pydev
(cd python-dev ;  docker build . -t kafka-pydev)