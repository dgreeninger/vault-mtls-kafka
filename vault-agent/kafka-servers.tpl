{{- with pkiCert "kafka-int-ca/issue/kafka-server" "ttl=3m" "common_name=broker-1.servers.kafka.acme.com" "alt_names=localhost" -}}
{{ .Key }}
{{ .Cert }}
{{ end }}
{{ with secret "kafka-int-ca/cert/ca_chain" }}
{{ .Data.ca_chain }}
{{ end }}
