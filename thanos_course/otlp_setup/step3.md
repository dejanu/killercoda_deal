
### Collector

![Scan results](./assets/otlp_setup.png)


* Start the collector: `kubectl apply -f otel-collector.yaml`{{copy}}

* And check again in grafana metric: `http_server_duration_milliseconds_count`