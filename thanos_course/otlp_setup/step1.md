
### Create the setup


*  Create the namespace `otel-tutorial`: `kubectl create namespace otel-tutorial`{{copy}}


* Deploy the app `kubectl apply -f app.yaml`{{copy}} and inspect it check the logs 

* Explore the app `kubectl  -n otel-tutorial exec <POD-NAME> -- cat app.py`{{copy}} .`app.py` never imports OpenTelemetry , 

* Describe the pod `kubectl -n otel-tutorial describe po <POD-NAME>`{{copy}}, check the Environment vars.

<details>
<summary>Hint</summary>
OTEL_SERVICE_NAME sets the name of the service (<code>otel-tutorial</code>)
OTEL_TRACES_EXPORTER sets the destination for collected traces: <code> otlp|console|none</code>
OTEL_METRICS_EXPORTER sets the destination for collected metrics  <code> otlp|console|none</code>
OTEL_EXPORTER_OTLP_ENDPOINT  set the target URL for the OTLP exporter across signals. <code>http://localhost:4317(gRPC)|http://localhost:4318(HTTP)</code>
</details>