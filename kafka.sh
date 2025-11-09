# ---------------------------------------------------------
# Starting Kafka services
# ---------------------------------------------------------

# Start ZooKeeper service
# ZooKeeper manages cluster coordination for Kafka (older Kafka versions)
./run-kafka_zookeeper_server.sh -s start

# Start Kafka broker (the actual message server)
./run-kafka_server.sh -s start


# ---------------------------------------------------------
# Topic management commands
# Modern Kafka uses --bootstrap-server instead of --zookeeper
# ---------------------------------------------------------

# | Purpose          | Command                                                                                                             |
# | ---------------- | ------------------------------------------------------------------------------------------------------------------- |
# | Create a topic   | kafka-topics.sh --create --topic my-topic --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1   |
# | List topics      | kafka-topics.sh --list --bootstrap-server localhost:9092                                                            |
# | Describe topic   | kafka-topics.sh --describe --topic my-topic --bootstrap-server localhost:9092                                       |
# | Delete topic     | kafka-topics.sh --delete --topic my-topic --bootstrap-server localhost:9092                                         |


# ---------------------------------------------------------
# Producing messages
# ---------------------------------------------------------

# Open a producer shell
# Anything you type is sent to the Kafka topic
kafka-console-producer.sh --topic my-topic --bootstrap-server localhost:9092


# ---------------------------------------------------------
# Consuming messages
# ---------------------------------------------------------

# Read all historical messages (start from earliest offset)
kafka-console-consumer.sh --topic my-topic --from-beginning --bootstrap-server localhost:9092

# Read only new incoming messages (live streaming)
kafka-console-consumer.sh --topic my-topic --bootstrap-server localhost:9092


# ---------------------------------------------------------
# Consumer group management
# ---------------------------------------------------------

# | Purpose              | Command                                                                                  |
# | -------------------- | ---------------------------------------------------------------------------------------- |
# | List consumer groups | kafka-consumer-groups.sh --bootstrap-server localhost:9092 --list                        |
# | Describe a group     | kafka-consumer-groups.sh --bootstrap-server localhost:9092 --describe --group my-group   |
# | Delete a group       | kafka-consumer-groups.sh --bootstrap-server localhost:9092 --delete --group my-group     |


# ---------------------------------------------------------
# Legacy (ZooKeeper-based) Kafka commands
# Only used in older Kafka versions (< 2.8)
# ---------------------------------------------------------

# Create topic using ZooKeeper instead of bootstrap server
# Note: --zookeeper is deprecated but appears in older tutorials
kafka-topics.sh --create --topic test --zookeeper localhost:9092 --partitions 1 --replication-factor 1

# Producer using the old broker-list flag
kafka-console-producer.sh --topic test --broker-list localhost:9092
