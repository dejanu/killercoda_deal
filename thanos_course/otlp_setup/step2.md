
### Backends


* Deploy the backends: `kubectl apply -f jaeger.yaml -f prometheus.yaml -f loki.yaml -f grafana.yaml`{{copy}}

* Check the state of the workloads: `kubectl -n otel-tutorial get po`{{copy}}

* Check in Grafana for `http_server_duration_milliseconds_count`{{copy}} metrics. 
Do a port-forward first `kubectl -n otel-tutorial port-forward  services/grafana 3000:3000`{{copy}}