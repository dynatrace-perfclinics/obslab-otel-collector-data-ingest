# dt-collector-demo
Hands on demo. Ingest logs, metrics and traces using the Dynatrace OpenTelemetry Collector.

## URL Formats

### Send Data to Dynatrace
```
https://{ENVIRONMENT-ID}.live.dynatrace.com/api/v2/otlp
eg.
https://abc12345.live.dynatrace.com
```

### Send Data via an Environment ActiveGate
```
https://{your-activegate-domain}:9999/e/{ENVIRONMENT-ID}/api/v2/otlp
eg.
https://YourCorp.internal:9999/e/abc12345/api/v2/otlp
```

### Send Data via a Containerised ActiveGate
```
https://{collector-service-name}.{collector-namespace}.svc.cluster.local/e/{ENVIRONMENT-ID}/api/v2/otlp
eg.
https://dt-collector.opentelemetry.svc.cluster.local/e/abc12345/api/v2/otlp
```
