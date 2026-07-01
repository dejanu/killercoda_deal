
### Deploy Prometheus

* Create deployment for Prometheus

```bash
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus
spec:
  replicas: 1
  selector:
    matchLabels: app: prometheus
  template:
    metadata:
      labels: app: prometheus
    spec:
      containers:
        - name: prometheus
          image: prom/prometheus
          ports:
            - containerPort: 9090
---
apiVersion: v1
kind: Service
metadata:
  name: prometheus
spec:
  selector: {app: prometheus}
  ports:
    - port: 9090
      targetPort: 9090
  type: ClusterIP
```

* Expose service (bind to all interfaces not just `localhost`)

```
kubectl port-forward --address 0.0.0.0 svc/prometheus 9090:9090
```

* Access HTTP Prometheus service which run in your environment