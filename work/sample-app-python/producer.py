# Adopted from : https://docs.confluent.io/clients-confluent-kafka-python/current/overview.html

from confluent_kafka import Producer
import socket
import time


conf = {
        # 'bootstrap.servers': "kafka1:19092",  # running within docker
        # 'bootstrap.servers': "localhost:9092", # running on host
        'bootstrap.servers': "localhost:9092,kafka1:19092", # running on host and docker
        'client.id': socket.gethostname()}

producer = Producer(conf)

topic = "test"
time_now_ms = time.time_ns() // 1_000_000
for i in range(1, 1000+1):
        key = "{}".format (time_now_ms + i)   # time in ms
        value = 'hello world @ {}'.format(key)
        producer.produce(topic, key=key, value=value)
        print ("Sending message #{}. key={}, value={}".format(i, key, value))
        time.sleep(0.5)

producer.flush()  # send all messages
