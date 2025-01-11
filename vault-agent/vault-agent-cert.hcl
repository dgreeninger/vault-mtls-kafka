pid_file = "/tmp/pidfile"

vault {
  address = "https://127.0.0.1:8200"
}

auto_auth {
  method {
    type      = "cert"
    config = {
      client_key = "/Users/dgreeninger/vault-agent-demo/vault.key"
      client_cert = "/Users/dgreeninger/vault-agent-demo/vault.crt"
      reload = true
    }
  }
  sink {
    type = "file"
    config = {
      path = "/tmp/vault-token-via-agent"
    }
  }
}

template {
  source = "vault-agent/kafka.tpl"
  destination = "pki/kafka-broker-1.pem"
  perms = 0600
  command = "openssl pkcs12 -inkey pki/kafka-broker-1.pem  -in pki/kafka-broker-1.pem  -name kafka-broker-1 -export  -out pki/kafka-broker-1.p12 -passin pass:changeme -passout pass:changeme && keytool -importkeystore -deststorepass changeme -destkeystore pki/kafka-broker-1-keystore.jks -srckeystore pki/kafka-broker-1.p12 -srcstoretype PKCS12 -srcstorepass changeme -noprompt && docker restart vault-mtls-kafka-kafka-1"
}
