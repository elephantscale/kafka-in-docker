# adopted from : https://docs.confluent.io/clients-confluent-kafka-python/current/overview.html

from confluent_kafka import Consumer, KafkaError

conf = {
        'bootstrap.servers': "kafka1:19092", # running within docker
        # 'bootstrap.servers': "localhost:9092", # running on host
        # 'bootstrap.servers': "localhost:9092,kafka1:19092", # running on host and docker
        'group.id': "foo",
        'auto.offset.reset': 'smallest'}

consumer = Consumer(conf)

topic = "test"
consumer.subscribe([topic])
print ("Listening on topic:", topic)

msg_count = 0
try:
    while True:
        msg = consumer.poll(timeout=1.0)
        if msg is None: continue

        msg_count += 1;
        if msg.error():
            if msg.error().code() == KafkaError._PARTITION_EOF:
                    # End of partition event
                    print('%% %s [%d] reached end at offset %d\n' %
                                    (msg.topic(), msg.partition(), msg.offset()))
        elif msg.error():
            print ("Exception: ", msg.error())
        else:
            print ("Received message # {}, key={},  value={},  topic={},  partition={},  offset={}".format (
                msg_count, msg.key(), msg.value(), 
                msg.topic(), msg.partition(),  msg.offset()))
finally:
    # Close down consumer to commit final offsets.
    consumer.close()
