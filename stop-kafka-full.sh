#!/bin/bash

docker-compose -f docker-compose-kafka-full.yml  down

docker-compose -f docker-compose-kafka-full.yml ps

exit 0