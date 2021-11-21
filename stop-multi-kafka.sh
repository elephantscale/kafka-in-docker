#/bin/bash

docker-compose -f docker-compose-multi-kafka.yml  down
docker-compose -f docker-compose-multi-kafka.yml  ps
exit 0