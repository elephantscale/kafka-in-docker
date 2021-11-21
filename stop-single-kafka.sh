#/bin/bash

docker-compose -f docker-compose-single-kafka.yml  down
docker-compose -f docker-compose-single-kafka.yml  ps
exit 0