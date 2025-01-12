pid_file = "/tmp/vault-agent-pidfile"

vault {
  address = "http://127.0.0.1:8200"
}

auto_auth {
  method {
    type = "token_file"

    config = {
      token_file_path = "vault-agent/.vault-token"
    }
  }
}

template {
  source = "vault-agent/kafka-servers.tpl"
  destination = "pki/kafka-broker-1.pem"
  perms = 0600
  command = "vault-agent/kafka-service.sh"

}

template {
  source = "vault-agent/kafka-consumer.tpl"
  destination = "pki/console-consumer.pem"
  perms = 0600
  command = "openssl pkcs12 -inkey pki/console-consumer.pem -in pki/console-consumer.pem -name console-consumer -export -out pki/console-consumer.p12 -passin pass:changeme -passout pass:changeme"
}

template {
  source = "vault-agent/kafka-producer.tpl"
  destination = "pki/console-producer.pem"
  perms = 0600
  command = "openssl pkcs12 -inkey pki/console-producer.pem -in pki/console-producer.pem -name console-producer -export -out pki/console-producer.p12 -passin pass:changeme -passout pass:changeme"
}
