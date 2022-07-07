# Python + Java  Development Environment for Kafka

Easy to use dev environment for Kafka with handy utilities for Python and Java

This container has

* JDK 11 + Maven
* Python 3.9
* Confluent Python library
* And other utilities like kakacat

You can find it here: [elephantscale/kafka-dev @ Dockerhub](https://hub.docker.com/repository/docker/elephantscale/kafka-dev)

## Get this

```bash
$   docker   pull  elephantscale/kafka-dev
```

## Run it

Easiest way to run this docker container is use the script:

```bash
$   ./start-kafka-dev.sh
```

Few notes:

* We are starting the docker container as `CURRENT_USER`,  so files created within the container will by owned by current user.  This is important when creating a compiling source code within the container.
* Also the current directory is mapped as `workspace` within the container.  It will be the default working directory.
* Also we are mounting the maven directory (`~/.m2`) into container.  This will reuse our downloaded maven artifacts within the container!

## Python Development

### Testing Kafka Connectivity

Start the container from the project root directory

```bash
$   cd   kafka-in-docker
$   ./start-kafka-dev.sh
```

Now you are within the container.  We will try a quick python test

```bash
$   python /python_kafka_test_client.py   kafka1:19092
# if the cluster is running, it will connect to the cluster
```

### Sample Python Application

We have a sample python application in : `sample-app-python`

Start one instance of kafka-dev instance

```bash
$   cd   kafka-in-docker
$   ./start-kafka-dev.sh
```

Within the container, run a consumer

```bash
$   cd sample-app-python
$   python  consumer.py
```

Start another instance of kafka-dev as follows:

```bash
$   cd   kafka-in-docker
$   ./start-kafka-dev.sh
```

Within the container, run a producer

```bash
$   cd sample-app-python
$   python  producer.py
```

Watch the events flowing from producer to consumer

![](../images/kafka-single-5a.png)

## Java App

We have a sample Java app in [sample-app-java](sample-app-java/)

Start Kafka dev env as follows:

```bash
$   cd kafka-in-docker
$   bash ./start-kafka-dev.sh
```

Within container, try the following:

```bash
$   cd sample-app-java

# build the Java app
$   mvn  clean package

# Run Java consumer
$    java -cp target/hello-kafka-1.0-jar-with-dependencies.jar   x.SimpleConsumer
```

Start another kafka-dev instance as follows:

```bash
$   cd kafka-in-docker
$   bash ./start-kafka-dev.sh
```

Within container, try the following:

```bash
$   cd sample-app-java

# build the Java app
$   mvn  clean package

# Run Java consumer
$    java -cp target/hello-kafka-1.0-jar-with-dependencies.jar   x.SimpleProducer
```

Watch the events flowing from producer to consumer

## Building   (Devs only)

```bash
$   docker   build .  -t elephantscale/kafka-dev

$   docker   build .  -t elephantscale/kafka-dev:1.0
```

Publish to docker hub

```bash
$   docker   login

$   docker   push   elephantscale/kafka-dev:1.0
$   docker   push   elephantscale/kafka-dev
```
