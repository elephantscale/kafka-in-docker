#!/bin/bash

docker-compose -f docker-compose-kafka-metrics.yml  down

docker-compose -f docker-compose-kafka-metrics.yml ps

exit 0