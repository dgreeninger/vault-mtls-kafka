{{- with pkiCert "kafka-int-ca/issue/kafka-client" "ttl=3m" "common_name=console-consumer.clients.kafka.acme.com" "alt_names=localhost" -}}
{{ .Key }}
{{ .Cert }}
{{ end }}
{{ with secret "kafka-int-ca/cert/ca_chain" }}
{{ .Data.ca_chain }}
{{ end }}
