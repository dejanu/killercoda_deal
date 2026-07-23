
### TSDB

* Restart the Prometheus pod: `kubectl  delete po -l app=prometheus`

* Prometheus [TSDB](https://github.com/prometheus/prometheus/blob/release-2.38/tsdb/docs/format/README.md) lives on the container's ephemeral filesystem in **data** dir: `kubectl exec -it prometheus-767cfdcb8b-rgjtg -- sh`

```
ls -ltr /prometheus/data
total 28
drwxr-xr-x    2 nobody   nobody        4096 Jul 23 20:03 wal
-rw-r--r--    1 nobody   nobody           0 Jul 23 20:03 lock
drwxr-xr-x    2 nobody   nobody        4096 Jul 23 20:03 chunks_head
-rw-r--r--    1 nobody   nobody       20001 Jul 23 20:12 queries.active
```

Ingested data is grouped into blocks, and each 2-hour block consists of a directory that contains a chunks subdirectory and an index file. The current block for incoming samples is kept in memory and not fully persisted and it's secured against crashes by WAL (write-ahead log).

* wal/ — Write-Ahead Log. Recent samples not yet compacted into blocks; used for crash recovery.
* chunks_head/ — In-memory head block's on-disk chunks (recent data, not yet flushed to a persisted block).
* queries.active — Tracks currently-running queries (for crash debugging), not metric data.
* lock — Lock file preventing multiple Prometheus processes from using the same data dir simultaneously


* Delete prometheus objects: `kubectl delete -f prometheus.yaml `

```yaml
# --------COnfig map ----
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
    scrape_configs:
      - job_name: 'node-exporter'
        static_configs:
          - targets: ['node-exporter:9100']
---
# ---------- PVC for Prometheus data ----------
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: prometheus-data
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
---
# ---------- Prometheus Deployment (with persistent storage) ----------
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus
  labels:
    app: prometheus
spec:
  replicas: 1
  selector:
    matchLabels:
      app: prometheus
  template:
    metadata:
      labels:
        app: prometheus
    spec:
      containers:
        - name: prometheus
          image: prom/prometheus:latest
          args:
            - --config.file=/etc/prometheus/prometheus.yml
            - --storage.tsdb.path=/prometheus
          ports:
            - containerPort: 9090
          volumeMounts:
            - name: config-volume
              mountPath: /etc/prometheus
            - name: data-volume
              mountPath: /prometheus
      volumes:
        - name: config-volume
          configMap:
            name: prometheus-config
        - name: data-volume
          persistentVolumeClaim:
            claimName: prometheus-data
---
apiVersion: v1
kind: Service
metadata:
  name: prometheus
  labels:
    app: prometheus
spec:
  selector:
    app: prometheus
  ports:
    - port: 9090
      targetPort: 9090
  type: ClusterIP
```