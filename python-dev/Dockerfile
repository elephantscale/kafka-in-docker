# Adapted with thanks from : https://github.com/rmoff/kafka-listeners/tree/master/python

FROM python:3.8

# We'll add netcat cos it's a really useful
# network troubleshooting tool
RUN apt-get update -yq && \
        apt-get -yq upgrade && \
        apt-get install -yq  --no-install-recommends \
                netcat  && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

# Install the Confluent Kafka python library
RUN pip install confluent_kafka

# We need a non-root user
# ARG USER_HOME_DIR="/home/dev"
# RUN groupadd -g 500 dev && \
#     useradd  -m -d ${USER_HOME_DIR}  -s /bin/bash   -g 500 -u 500  dev


# # Add our script
# COPY ./python_kafka_test_client.py ${USER_HOME_DIR}

# RUN chown dev:dev -R ${USER_HOME_DIR}

# WORKDIR ${USER_HOME_DIR}

# USER dev
COPY ./python_kafka_test_client.py /
# ENTRYPOINT [ "python", "/python_kafka_test_client.py"]
# CMD [ "python", "/python_kafka_test_client.py"]
CMD [ "/bin/bash"]