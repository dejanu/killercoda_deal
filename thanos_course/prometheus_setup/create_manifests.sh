
cat > node-exporter.yaml <<- "EOF"
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-exporter
  labels:
    app: node-exporter
spec:
  selector:
    matchLabels:
      app: node-exporter
  template:
    metadata:
      labels:
        app: node-exporter
    spec:
      hostNetwork: true
      hostPID: true
      containers:
        - name: node-exporter
          image: prom/node-exporter:latest
          ports:
            - containerPort: 9100
              hostPort: 9100
          args:
            - --path.rootfs=/host
          volumeMounts:
            - name: rootfs
              mountPath: /host
              readOnly: true
      volumes:
        - name: rootfs
          hostPath:
            path: /
---
apiVersion: v1
kind: Service
metadata:
  name: node-exporter
  labels:
    app: node-exporter
spec:
  clusterIP: None        # headless — resolves to all pod IPs directly
  selector:
    app: node-exporter
  ports:
    - port: 9100
      targetPort: 9100
      name: metrics
EOF

cat > prometheus.yaml <<- "EOF"
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
          ports:
            - containerPort: 9090
          volumeMounts:
            - name: config-volume
              mountPath: /etc/prometheus
      volumes:
        - name: config-volume
          configMap:
            name: prometheus-config
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
EOF