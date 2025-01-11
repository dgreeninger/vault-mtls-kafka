{{- with pkiCert "kafka-int-ca/issue/kafka-server" "ttl=3m" "common_name=broker-1.servers.kafka.acme.com" "alt_names=localhost" -}}
{{ .Cert }}
{{ .CA }}
{{ .Key }}
{{ end }}
