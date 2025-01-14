# Confluent Platform with Vault as PKI and Vault Agent to manage the certificate lifecycle.

Vault can be used as a PKI provider to manage SSL/TLS certificates.
Vault Agent can be configured to automatically request/renew the certificate and then restart Kafka, so the certificates remain valid.

This example builds on work done by [jeqo](https://github.com/jeqo)

The goal is to extend the original [example](https://github.com/jeqo/docker-composes/tree/main/cp-vault-pki) and introduce the user to Vault Agent to manage the renewal of the certificates.

## How to run

TL;DR:

```shell
make prep
```

This will:

- Clean PKI dir,
- Start Vault
- Create PKI and roles
- Use Vault Agent to create Certificates and KeyStores
- Start Kafka and create a topic


Finally, start producer and consumer:

```shell
make consumer_run
```

```shell
make producer_run
```

Finally, to clean up: `make destroy`

## Scenarios

### Revoke Certificates

Pre-conditions:

- Brokers need to be configured with CRL enabled to validate revocation list:

```yaml
      ## Here is where CRL validation for revoked certificates is enabled.
      KAFKA_OPTS: "-Dcom.sun.security.enableCRLDP=true -Dcom.sun.net.ssl.checkRevocation=true"
```
Source: [docker-compose](https://github.com/dgreeninger/vault-mtls-kafka/blob/main/docker-compose.yml#L70) Kafka environment definition.

- producer and consumer are writing and reading data properly.

Check certificates created on the intermediary CA:

![Certificates](certificates.png)

Revoke certificate

![Revoke certificate](revoke.png)

Try to connect again and produce:

```shell
make producer_run
/usr/local/apache/kafka/kafka_2.13-3.1.0/bin/kafka-console-producer.sh --topic test --bootstrap-server localhost:9093 \
                --producer.config ./config/producer.properties
>[2022-02-01 12:59:13,550] ERROR [Producer clientId=console-producer] Connection to node -1 (localhost/127.0.0.1:9093) failed authentication due to: SSL handshake failed (org.apache.kafka.clients.NetworkClient)
```
