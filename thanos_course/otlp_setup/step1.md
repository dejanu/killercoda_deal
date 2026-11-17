
### Create the setup


*  Create the namespace `otel-tutorial`: `kubectl create namespace otel-tutorial`{{copy}}


* Deploy the app `kubectl apply -f app.yaml`{{copy}} and inspect it check the logs 

* Explore the app 


`app.py` never import OpenTelemetry , the way the container is started allows OpenTelemetry libs/SDK to inject instrumentation into the app.