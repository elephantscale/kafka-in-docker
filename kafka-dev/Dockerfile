# Adapted with thanks from : https://github.com/rmoff/kafka-listeners/tree/master/python

FROM maven:3-jdk-11

RUN apt-get update -yq && \
        apt-get -yq upgrade && \
        apt-get install -yq  --no-install-recommends \
                python3  python3-pip  \
                netcat  \
                kafkacat && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3  /usr/bin/python

# Install the Confluent Kafka python library
RUN pip install confluent_kafka


RUN mkdir -p /root/.m2

# python kafka test script
COPY ./python_kafka_test_client.py /

## maven config
COPY ./maven-settings.xml   /usr/share/maven/conf/settings.xml

CMD [ "/bin/bash"]