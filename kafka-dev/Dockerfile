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

# Setup Kafka in /usr/local/kafka
RUN   cd /usr/local && \
      wget -q https://dlcdn.apache.org/kafka/3.2.0/kafka_2.12-3.2.0.tgz && \
      tar xf kafka_2.12-3.2.0.tgz && \
      mv kafka_2.12-3.2.0    kafka  && \
      rm -f kafka_2.12-3.2.0.tgz

ENV PATH  ${PATH}:/usr/local/kafka/bin

CMD [ "/bin/bash"]