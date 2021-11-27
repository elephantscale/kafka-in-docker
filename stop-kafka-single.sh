#/bin/bash

docker-compose -f docker-compose-kafka-single.yml   down
docker-compose -f docker-compose-kafka-single.yml   ps
exit 0