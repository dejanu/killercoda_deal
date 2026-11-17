
### Create the setup


*  Create the namespace `otel-tutorial`: `kubectl create namespace otel-tutorial`{{copy}}


* Deploy the app `kubectl apply -f app.yaml`{{copy}} and inspect it check the logs 

* Generate some traffic

`kubectl -n otel-tutorial port-forward svc/otel-app 8080:8080`{{copy}} and in antoher session tab `for i in {1..20}; do curl -s localhost:8080 >/dev/null; sleep 0.2; done`{{copy}}

* Explore the app `kubectl exec <pod> -- cat app.py`{{copy}} .`app.py` never imports OpenTelemetry , the way the container is started allows OpenTelemetry libs/SDK to inject instrumentation into the app.