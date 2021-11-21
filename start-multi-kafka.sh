#!/bin/bash

export CURRENT_USER="$(id -u):$(id -g)"
# echo $CURRENT_USER

docker-compose -f docker-compose-multi-kafka.yml  up -d

docker-compose -f docker-compose-multi-kafka.yml  ps

echo -e "\n------------------------------------------------------------------------------------------------------"
echo -e "All services started!"
echo -e "Kafka UI Manager : http://localhost:9000"
echo -e "\n------------------------------------------------------------------------------------------------------"

exit 0