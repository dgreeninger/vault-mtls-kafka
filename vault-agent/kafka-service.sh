#!/bin/bash
openssl pkcs12 -inkey pki/kafka-broker-1.pem  -in pki/kafka-broker-1.pem  -name kafka-broker-1 -export  -out pki/kafka-broker-1.p12 -passin pass:changeme -passout pass:changeme
keytool -importkeystore -deststorepass changeme -destkeystore pki/kafka-broker-1-keystore.jks -srckeystore pki/kafka-broker-1.p12 -srcstoretype PKCS12 -srcstorepass changeme -noprompt
echo changeme > ./pki/kafka_broker_1_keystore_credential
echo changeme > ./pki/kafka_broker_1_key_credential

# Check if Kafka container is running
if docker ps --filter "name=vault-mtls-kafka-kafka-1" --format "{{.Names}}" | grep -q "vault-mtls-kafka-kafka-1"; then
  echo "Kafka container is already running. Restarting Kafka service..."
  docker-compose restart kafka
else
  echo "Kafka container is not running. Starting containers with docker-compose up..."
  docker-compose up -d kafka zookeeper
fi
