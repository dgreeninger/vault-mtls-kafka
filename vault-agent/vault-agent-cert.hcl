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
  source = "/Users/dgreeninger/docker-composes/cp-vault-pki/kafka.tpl"
  destination = "/Users/dgreeninger/docker-composes/cp-vault-pki/pki/kafka-broker-1.pem"
  perms = 0400
  command = "openssl pkcs12 -inkey /Users/dgreeninger/docker-composes/cp-vault-pki/pki/kafka-broker-1.pem  -in /Users/dgreeninger/docker-composes/cp-vault-pki/pki/kafka-broker-1.pem  -name kafka-broker-1 -export  -out /Users/dgreeninger/docker-composes/cp-vault-pki/pki/kafka-broker-1.p12 -passin pass:changeme -passout pass:changeme && keytool -importkeystore -deststorepass changeme -destkeystore /Users/dgreeninger/docker-composes/cp-vault-pki/pki/kafka-broker-1-keystore.jks -srckeystore /Users/dgreeninger/docker-composes/cp-vault-pki/pki/kafka-broker-1.p12 -srcstoretype PKCS12 -srcstorepass changeme -noprompt && docker restart cp-vault-pki-kafka-1"
}
