# Quickstart - Multi Node Kafka With Monitoring

## Overview

![](images/beer-1a.png)
![](images/beer-1a.png)
![](images/beer-1a.png)
![](images/beer-1a.png)
![](images/beer-1a.png)
![](images/beer-1a.png)
![](images/beer-1a.png)
![](images/beer-1a.png)
![](images/beer-1a.png)
![](images/beer-1a.png)
![](images/beer-1a.png)
![](images/beer-1a.png)
![](images/beer-1a.png)

This stack is **everything**.  Starts...

* 1 x zookeeper
* 3 x Kafka brokers
* Kafka UI Manager
* Monitoring stack
    - Prometheus (metrics database)
    - Grafana (visualizing metrics)
    - Caddy (proxying)
    - Node exporter (to collect host metrics)
    - Push gateway (to collect metrics)
    - 3 x JMX collectors (to collect Kafka metrics)

## Step-1: Build Custom Docker Images

Only need to do this once.

```bash
$   cd  kafka-in-docker
$   bash ./build-images.sh
```

## Step-2: Start the stack

```bash
$   bash start-kafka-full.sh
```

## Step-3: Login to a Kafka broker

Login to a kafka node

```bash
$   docker-compose  -f docker-compose-kafka-full.yml  exec  kafka1  bash
```

## Step-4: Create a Test Topic

We do this **within the `kafka1` container**, we just started.

```bash
# See current topics
$    kafka-topics --bootstrap-server kafka1:19092  --list

# Create a new topic
$   kafka-topics  --bootstrap-server kafka1:19092   \
       --create --topic test --replication-factor 3  --partitions 10

# Describe topic
$   kafka-topics  --bootstrap-server kafka1:19092   \
       --describe --topic test 
```

## Step-5: Start Console Consumer

We do this **within the `kafka1` container**, we just started.

```bash
$    kafka-console-consumer --bootstrap-server kafka1:19092   \
         --property print.key=true --property key.separator=":"  --topic test

```

Note, our kafka bootstrap server is `kafka1:19092`, this is the advertised kafka broker address in docker network.

## Step-6: Start Console Producer

On another terminal, login to another Kafka node

```bash
$   docker-compose -f docker-compose-kafka-full.yml  exec kafka2  bash
```

Within the kafka container, start the console producer

Run producer

```bash
$    kafka-console-producer --bootstrap-server kafka2:19092  --topic test
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

![](images/kafka-multi-1.png)

Click on the brokers, and you will see broker details.  You can also see JMX metrics are published!

![](images/kafka-multi-2.png)

Click on broker id, to see more detailed stats on a broker.

![](images/kafka-multi-3.png)

## Step-8: Developing Applications

Let's develop a sample app in Java and Python.

## Step-9: Java App

We have a sample Java app in [work/sample-app-java](work/sample-app-java/)

And we have a java development environent ready!  You don't even need to have Java or Maven installed on your computer :-) 

Start Java dev env:

```bash
$   cd kafka-in-docker
$   bash ./start-java-env.sh
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

We have a sample python app in [work/sample-app-python](work/sample-app-python/)

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

## Step-11: Checkout Metrics

This stack has has a full compliment of monitoring tools.

Checkout Prmometheus UI at [localhost:9090](http://localhost:9090) .  Here we see all data sources are up and running.

![](images/kafka-full-1.png)

## Step-12: Visualize with Grafana

Grafana UI is [localhost:3000](http://localhost:3000)

Login with credentials:

- username: admin
- password: kafka

Here is a sample Grafana UI with pre-defined dashboards.

![](images/kafka-full-2.png)

### Kafka / Brokers JVM & OS  Dashboard

![](images/kafka-full-3.png)

### Kafka Cluster / Global Healthcheck Dashboard

![](images/kafka-full-4a.png)

### Kafka Topics Dashboard

![](images/kafka-full-5a.png)

## Step-13: Shutdown

```bash
$   bash ./stop-kafka-full.sh
```
