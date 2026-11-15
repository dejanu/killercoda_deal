
### Deploy Prometheus and Node Exporter



* In the current directory are the manifest for Prometheus and Node exporter, that will create the needed objects:

```
configmap/prometheus-config 
deployment.apps/prometheus 
service/prometheus 

daemonset.apps/node-exporter 
service/node-exporter 
```

* Deploy `kubectl apply -f prometheus.yaml` and `kubectl apply -f node-exporter.yaml`

* Verify deployments `kubectl get po -owide`

* Expose prometheus service (bind to all interfaces not just `localhost`): `kubectl port-forward --address 0.0.0.0 svc/prometheus 9090:9090`