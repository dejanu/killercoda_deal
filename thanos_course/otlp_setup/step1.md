
### Create the setup


*  Create the namespace `otel-tutorial`: `kubectl create namespace otel-tutorial`{{copy}}


* Deploy the app `kubectl apply -f app.yaml`{{copy}} and inspect it check the logs 

* Explore the app `kubectl  -n otel-tutorial exec <POD-NAME> -- cat app.py`{{copy}} .`app.py` never imports OpenTelemetry , the way the container is started allows OpenTelemetry libs/SDK to inject instrumentation into the app.