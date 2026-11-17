
### Backends


* Deploy the backends: `kubectl apply -f jaeger.yaml -f prometheus.yaml -f loki.yaml -f grafana.yaml`{{copy}}

* Check the state of the workloads: `kubectl -n otel-tutorial get po`{{copy}}

* Check in Grafana for `http_server_duration_milliseconds_count`{{copy}} metrics. Do a port-forward first `kubectl -n otel-tutorial port-forward --address  0.0.0.0 services/grafana 3000:3000`{{copy}}

* Generate some traffic: `kubectl -n otel-tutorial port-forward svc/otel-app 8080:8080`{{copy}} and in another session tab `for i in {1..20}; do curl -s localhost:8080 >/dev/null; sleep 0.2; done`{{copy}}

* Check jaeger: `kubectl -n otel-tutorial port-forward --address  0.0.0.0 services/jaeger 16686:16686`{{copy}} for the desired service `otel-tutorial`

<details>
<summary>Hint</summary>
The app has no address for jaeger, Prometheus or Loki. Traces,Logs,Metric go to the collector over OTLP gRPC.
Without the collector we don't have metrics or logs.
</details>