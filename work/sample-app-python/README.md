# Sample Python App

## Prep

Follow the [parent README](../../README.md) to setup `test` topic

## Code

- [producer.py](producer.py)
- [consumer.py](consumer.py)

## Running

Run the python code within `python-dev` container

```bash
# Go to project root dir
$   cd kafka-in-docker  

# start all services
$   ./start-all.sh

# start python-dev container
$   ./start-python-dev.sh
# this will drop you into /work directory in container

# go to python app dir
$   cd sample-app-python
```

Running consumer

```bash
$   python consumer.py
```

Leave this running.

From another terminal, start another instance of `python-dev` container

Running producer

```bash
# Go to project root dir
$   cd kafka-in-docker  

# start python-dev container
$   ./start-python-dev.sh
# this will drop you into /work directory in container

# go to python app dir
$   cd sample-app-python
```

Run producer

```bash
$   python producer.py
```

You will see messages go from producer --> consumer

