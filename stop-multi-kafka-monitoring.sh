#!/bin/bash

docker-compose -f docker-compose-multi-kafka-monitoring.yml  down

docker-compose -f docker-compose-multi-kafka-monitoring.yml ps

exit 0