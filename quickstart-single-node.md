# Quickstart - Single Node Kafka

## Overview

Components started :

![](images/beer-1a.png)
![](images/beer-1a.png)
![](images/beer-1a.png)

This stack has:

- 1 x Zookeeper
- 1 x Kafka broker
- Kafka UI Manager

## Step-1: Build Custom Docker Images

Only need to do this once.

```bash
$   cd  kafka-in-docker
$   bash ./build-images.sh
```

## Step-2: Start the stack

```bash
$   bash start-kafka-single.sh
```

## Step-3: Login to a Kafka broker

```bash
$   docker-compose -f docker-compose-kafka-single.yml  exec kafka1  bash
```

## Step-4: Create a Test Topic

We do this **within the `kafka1` container**, we just started.

```bash
# See current topics
$    kafka-topics.sh --bootstrap-server kafka1:19092  --list

# Create a new topic
$   kafka-topics.sh--bootstrap-server kafka1:19092   \
       --create --topic test --replication-factor 1  --partitions 2

# Describe topic
$   kafka-topics.sh--bootstrap-server kafka1:19092   \
       --describe --topic test 
```

## Step-5: Start Console Consumer

We do this **within the `kafka1` container**, we just started.

```bash
$    kafka-console-consumer.sh  --bootstrap-server kafka1:19092   \
         --property print.key=true --property key.separator=":"  --topic test

```

Note, our kafka bootstrap server is `kafka1:19092`, this is the advertised kafka broker address in docker network.

## Step-6: Start Console Producer

On another terminal, login to Kafka node again

```bash
$   docker-compose -f docker-compose-kafka-single.yml  exec kafka1  bash
```

Within the kafka container, start the console producer

Run producer

```bash
$    kafka-console-producer.sh --bootstrap-server kafka1:19092  --topic test
```

Type a few lines into console producer terminal

```text
1
2
3
4
```

And watch it come out on console terminal

## Step-7: Kafka Manager UI

Access Kafka Manager UI on url : [http://localhost:9000](http://localhost:9000)

Register our new Kafka cluster as follows

![](images/kafka-manager-1.png)

Once registered, you will see topics and brokers displayed like this.

![](images/kafka-single-2.png)

Click on the brokers, and you will see broker details.  You can also see JMX metrics are published!

![](images/kafka-single-3.png)

Click on broker id, to see more detailed stats on a broker.

![](images/kafka-single-4.png)

## Step-8: Developing Applications

Let's develop a sample app in Java and Python.

## Step-9: Java App

We have a sample Java app in [work/sample-app-java](work/sample-app-java/)

And we have a java development environent ready!  You don't even need to have Java or Maven installed on your computer :-) 

Start Java dev env:

```bash
$   cd kafka-in-docker
$   bash ./start-java-dev.sh
```

This will drop you into `work` directory in the container.

The following commands are executed in Java container

```bash
$   cd sample-app-java

# build the Java app
$   mvn  clean package

# Run Java consumer
$    java -cp target/hello-kafka-1.0-jar-with-dependencies.jar   x.SimpleConsumer
```

## Step-10: Python app

From another terminal, start python-dev environment

```bash
$   cd kafka-in-docker
$   bash ./start-python-dev.sh
```

Within python container, try these

```bash
# we are currently in /work directory
$   cd sample-app-python

# run producer
$   python  producer.py
```

Now, observe output on console-consumer and java-consumer windows!  And check-out the Kafka-manager UI too.

![](images/kafka-single-5a.png)

## Step-11: Shutdown

```bash
$   bash ./stop-kafka-single.sh
```