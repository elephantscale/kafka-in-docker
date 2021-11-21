# Running Multi-Broker Kafka using Docker

Run multiple Kafka brokers, effortlessly!

This stack offers a complete Kafka development environment on localhost.  You can run a single broker kafka cluster or **multi-broker Kafka cluster** on localhost.

Also a Kafka UI is included.

Plus we have full monitoring stack using Grafana and Prometheus stack.

And finally we have a Java and Python development environments also!

## Quick start

### Quickstart-1: Clone this repo

```bash
$   git clone https://github.com/elephantscale/kafka-in-docker
```

### Quickstart-2: Build docker containers

Only have to do this once

```bash
$   cd  kafka-in-docker
$   docker-compose  -f docker-compose-multi-kafka.yml  build
```

### Quickstart-3: Start services

There are various stack configurations to fit your need.

**1 - Single broker Kafka** 

This one starts up

- 1 x Zookeeper 
- 1 x Kafka broker
- Kafka UI Manager

```bash
$   bash start-single-kafka.sh
```

**2 - Multi broker Kafka**

This one starts

- 1 x Zookeeper
- 3 x Kafka brokers
- Kafka UI Manager

```bash
$   bash  start-multi-kafka.sh
```

**3 - Multi broker Kafka + Monitoring stack**

This stack is **everything**.  Starts...

- 1 x zookeeper
- 3 x Kafka brokers
- Kafka UI Manager
- Prometheus
- Grafana

```bash
$   bash ./start-multi-kafka-monitoring.sh
```


### Quickstart-4: Create a test topic

Login to a Kafka broker

```bash
$   docker-compose exec  kafka1  bash
```

Execute the following in Kafka docker

```bash
$    kafka-topics --bootstrap-server kafka1:19092  --list
```

Create a new topic

```bash
$   kafka-topics  --bootstrap-server kafka1:19092   \
       --create --topic test --replication-factor 3  --partitions 10
```

Describe topic

```bash
$   kafka-topics  --bootstrap-server kafka1:19092   \
       --describe --topic test 
```

### Quickstart-5: Console Consumer

Login to one of Kafka brokers

```bash
$   docker-compose exec  kafka2  bash
```

And start console consumer

```bash
$    kafka-console-consumer --bootstrap-server kafka2:19092  --topic test
```

### Quickstart-6: Console Producer

Let's login to another kafka broker and run console producer

```bash
$   docker-compose exec  kafka1  bash
```

Run producer

```bash
$    kafka-console-producer --bootstrap-server kafka1:19092  --topic test
```

Type a few things like

```text
1
2
3
4
```

And make sure you can see the output on console-consumer

There we go.  Our Kafka brokers are up and running

## Kafka Cluster Manager UI

This stack includes a pretty nice UI by [Kafka cluster manager](https://github.com/yahoo/CMAK).  We can manage Kafka topics and brokers right from this UI and see metrics

Go to [localhost:9000](localhost:9000) to access Kafka Manager UI.

And register your Kafka cluster as follows

![](images/kafka-manager-1.png)

## Setup Explained

![](images/kafka-in-docker-1.svg)

* Zookeeper container listens on port 2181 on localhost and docker network
* There are 3 kafka broker containers running
* Each Kafka broker has 2 listeners.
    - port 19092 for docker network
    - one of the ports 9092 or 9093 or 9094, that is mapped to localhost
* Kafka docker hostnames are `kafka1`, `kafka2`, `kafka3`
* All zookeeper/kafka containers are mapped to local volumes, so the data is safe

It may be a bit of complex setup.  But docker-compose makes it easy manage

## Developing Kafka Apps

[Sample Java app](work/sample-app-java/README.md)

[Sample python app](work/sample-app-python/README.md)

## A Note about permissoins

`./work` directory is mounted on `java-dev` and 'python-dev` containers.  We mount this using current user id, so the files will have the correct permissions, even when created from within the container

In order for the permissions to work, you need to start these containers using the scripts like this:

```bash
$   ./start-java-dev.sh
$   ./start-python-dev.sh
```

## Reset Every thing

Delete the docker volumes to clear all zookeeper / broker data

```bash
$   docker-compose down -v
```

## Troubleshooting Kafka Broker Connectivity

I have adopted this excellent python script [python_kafka_test_client.py](https://github.com/rmoff/kafka-listeners/blob/master/python/python_kafka_test_client.py) with thanks!

**Running this script on host:**

I recommend creating a custom python environment, so we keep our python environments clean.

```bash
$   conda create --name pykafka python=3.8
$   conda activate pykafka
$   pip3 install confluent_kafka
```

Now run the script:

```bash
$   python python-dev/python_kafka_test_client.py 
```

**Running the python script in container**

```bash
$   bash ./start-python-dev.sh
# this will spin up our python dev container

# inside the container, execute this
# Note: we are specifying kafka broker and host that is exposed within docker network
$   python /python_kafka_test_client.py    kafka1:19092
```

## Changes I Made

**Maven settings.xml**

[java/settings.xml](java/settings.xml) sets the default Maven repository to `/var/maven/.m2/repository`.  It is mapped to `/usr/share/maven/conf/settings.xml` on mvn image.

## References

### Other Kafka Images

- [bitnami/kafka](https://hub.docker.com/r/bitnami/kafka)

### Excellent guides that helped me

- The grafana / prometheus part is heavily borrowed, with much thanks, from [https://github.com/streamthoughts/kafka-monitoring-stack-docker-compose](https://github.com/streamthoughts/kafka-monitoring-stack-docker-compose) - a very nicely done monitoring stack for Kafka!
- https://www.confluent.io/blog/kafka-client-cannot-connect-to-broker-on-aws-on-docker-etc/
    - connecting from Eclipse
- https://github.com/rmoff/kafka-listeners
	- very nice writeup
	- brilliant python test client to troubleshoot conenectivity issues : https://github.com/rmoff/kafka-listeners/blob/master/python/python_kafka_test_client.py
- https://github.com/wurstmeister/kafka-docker - another attempt at dockerizing Kafka