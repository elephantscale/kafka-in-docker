#!/bin/bash

export CURRENT_USER="$(id -u):$(id -g)"
# echo $CURRENT_USER

docker-compose -f docker-compose-kafka-full.yml  up -d

docker-compose -f docker-compose-kafka-full.yml  ps

echo -e "\n------------------------------------------------------------------------------------------------------"
echo -e "All services started!"
echo -e "Kafka Manager UI : http://localhost:9000"
echo -e "Grafana  : http://localhost:3000   (Login : admin / Password : kafka)"
echo -e "Prometheus  : http://localhost:9090"
echo -e "\n------------------------------------------------------------------------------------------------------"