# Dockerized Yahoo CMAK (Formerly 'Kafka Manager')

This is the popular [Yahoo CMAK](https://github.com/yahoo/CMAK)

[elephantscale/cmak @ dockerhub](https://hub.docker.com/repository/docker/elephantscale/cmak)

## Download this

```bash
$   docker pull  elephantscale/cmak
```

## Running on Single Kafka Instance

### Start kafka on your local machine

```bash
# Go to where your Kafka is installed
$   cd ~/apps/kafka  # or cd  /path/to/kafka

# start zookeeper
$    bin/zookeeper-server-start.sh    config/zookeeper.properties

# start kafka
$   JMX_PORT=9999  bin/kafka-server-start.sh -daemon \
        config/server.properties
```

### Now Start Kafka Manager  

A few things to note

* The default configuration looks for zookeeper in `localhost:2181,zookeeper:2181`
* You want to start the networking in `host` mode.  This way it can find zookeeper  at `localhost:2181`
* And map the port 9000 to container
* And we are naming our container `cmak` for easy identification

```bash
$   docker run -d --rm --name cmak -p 9000:9000 \
               --net host  \
               elephantscale/cmak
```

Go to [localhost:9000](http://localhost:9000) in your browser and you will see CMAK UI!

See [Using CMAK](#using-cmak) section below.

### Stopping Kafka Manager Container

```bash
$   docker stop cmak  # if you named the container as cmak

# or 
$   docker ps
# identify the CMAK container id
$   docker stop   aaaabbbbccc
```

## Using CMAK

### Register a Kafka Cluster

![](images/cmak-1.png)

### Register a Kafka Cluster with these Properties

* Cluster name: can be anything you want
* zookeeeper name: must be `localhost:2181`
* Enable JMX polling
* Enable consumer polling

![](images/cmak-2.png)

### Click around and enjoy

For example, if you click on `Brokers` you will start seeing JMX stats showing up!

![](images/cmak-3.png)

## To Build Docker Image (Devs only)

```bash
$   docker build .  -t cmak
$   docker build .  -t elephantscale/cmak
```

Pushing to docker hub

```bash
$   docker login
$   docker push  elephantscale/cmak
```
