# Sample Kafka Java App

Recommended approach is to use an IDE like Eclipse or IntelliJ-idea.  We will run these on host machine (not within docker)

Open this project in Eclipse or IntelliJ as a 'maven project'

**Note about brokers settings:**

In app code, you will notice, we specify 2 brokers

```java
props.put("bootstrap.servers", "localhost:9092,kafka1:19092");
```

- `localhost:9092` will work for connecting from host (i.e.  from Eclipse)
- `kafka1:19092` will work within Kafka docker containers using docker networking

We will have both, so the code can work inside/outside containers.

Run `SimpleConsumer`.  This will listen on `test` topic we just created.

Now run `SimpleProducer`;  This will publish messages into `test` topic.  And you can see messages on the consumer.

## Compiling the code using Maven

We will use Maven to compile the Java code.  You don't need to install maven on your machine.  We have a **dev environment** ready!

Start a dev container

```bash
$   bash ./start-java-dev.sh
```

This will start `java-dev` container and put you in `/home/maven/work` directory.  This directory has the contents of our `work` directory from host.

Kick off compile

```bash
$   cd /home/maven/work/sample-app-java

$   mvn clean package

$   ls -lh target/
```

**Note**: The maven .m2 directory is in `/var/maven/.m2`.  This directory is mounted from host dir `./maven-m2-cache`.  So the downloaded artifacts are persisted.

Run consumer:

```bash
$   java -cp target/hello-kafka-1.0-jar-with-dependencies.jar   x.SimpleConsumer
```

Now start another container and run producer

```bash
$   bash ./start-java-dev.sh
```

Run producer

```bash
$   cd work/sample-app-java
$    java -cp target/hello-kafka-1.0-jar-with-dependencies.jar   x.SimpleProducer
```

You will see messages showing up on consumer.
Yay!
