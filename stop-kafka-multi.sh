#/bin/bash

docker-compose -f docker-compose-kafka-multi.yml  down
docker-compose -f docker-compose-kafka-multi.yml  ps
exit 0