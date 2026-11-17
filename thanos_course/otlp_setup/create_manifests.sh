cat > app.yaml <<- "EOF"
# Flask app with zero-code instrumentation. The image's CMD is
# `opentelemetry-instrument python app.py`; all telemetry config comes from the env below.
apiVersion: apps/v1
kind: Deployment
metadata:
  name: otel-app
  namespace: otel-tutorial
  labels:
    app: otel-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: otel-app
  template:
    metadata:
      labels:
        app: otel-app
    spec:
      containers:
        - name: otel-app
          image: dejanualex/otel-app:1.0
          ports:
            - name: http
              containerPort: 8080
          env:
            - name: OTEL_SERVICE_NAME
              value: otel-tutorial
            - name: OTEL_TRACES_EXPORTER
              value: otlp
            - name: OTEL_METRICS_EXPORTER
              value: otlp
            - name: OTEL_LOGS_EXPORTER
              value: otlp
            - name: OTEL_PYTHON_LOGGING_AUTO_INSTRUMENTATION_ENABLED
              value: "true"
            - name: OTEL_PYTHON_LOG_LEVEL
              value: info
            - name: OTEL_METRIC_EXPORT_INTERVAL
              value: "5000"
            # All signals go to the collector (gRPC); it fans out to the backends.
            - name: OTEL_EXPORTER_OTLP_ENDPOINT
              value: http://otel-collector:4317
            # Adds k8s context to every span/metric/log as resource attributes.
            - name: K8S_POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: K8S_NAMESPACE_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
            - name: OTEL_RESOURCE_ATTRIBUTES
              value: k8s.pod.name=$(K8S_POD_NAME),k8s.namespace.name=$(K8S_NAMESPACE_NAME)
          # TCP probes on purpose: GET / calls an external site and would create a trace per probe.
          readinessProbe:
            tcpSocket:
              port: http
            periodSeconds: 10
          livenessProbe:
            tcpSocket:
              port: http
            initialDelaySeconds: 10
            periodSeconds: 20
          resources:
            requests:
              cpu: 50m
              memory: 128Mi
            limits:
              memory: 256Mi
          securityContext:
            allowPrivilegeEscalation: false
---
apiVersion: v1
kind: Service
metadata:
  name: otel-app
  namespace: otel-tutorial
spec:
  type: ClusterIP
  selector:
    app: otel-app
  ports:
    - name: http
      port: 8080
      targetPort: http
EOF

cat > otel-collector.yaml <<- "EOF"
# Same pipelines as ../otel-collector-config.yaml, with in-cluster Service names
# as exporter targets (no host.docker.internal in Kubernetes).
apiVersion: v1
kind: ConfigMap
metadata:
  name: otel-collector-config
  namespace: otel-tutorial
data:
  config.yaml: |
    receivers:
      otlp:
        protocols:
          grpc:
            endpoint: 0.0.0.0:4317
          http:
            endpoint: 0.0.0.0:4318

    processors:
      batch:

    exporters:
      otlp/jaeger:
        endpoint: jaeger:4317
        tls:
          insecure: true
      otlphttp/prometheus:
        endpoint: http://prometheus:9090/api/v1/otlp
      otlphttp/loki:
        endpoint: http://loki:3100/otlp
      debug:
        verbosity: basic

    service:
      pipelines:
        traces:
          receivers: [otlp]
          processors: [batch]
          exporters: [otlp/jaeger, debug]
        metrics:
          receivers: [otlp]
          processors: [batch]
          exporters: [otlphttp/prometheus]
        logs:
          receivers: [otlp]
          processors: [batch]
          exporters: [otlphttp/loki, debug]
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: otel-collector
  namespace: otel-tutorial
  labels:
    app: otel-collector
spec:
  replicas: 1
  selector:
    matchLabels:
      app: otel-collector
  template:
    metadata:
      labels:
        app: otel-collector
    spec:
      containers:
        - name: otel-collector
          image: otel/opentelemetry-collector:latest
          args: ["--config=/etc/otelcol/config.yaml"]
          ports:
            - name: otlp-grpc
              containerPort: 4317
            - name: otlp-http
              containerPort: 4318
          volumeMounts:
            - name: config
              mountPath: /etc/otelcol
          resources:
            requests:
              cpu: 50m
              memory: 128Mi
            limits:
              memory: 512Mi
      volumes:
        - name: config
          configMap:
            name: otel-collector-config
---
apiVersion: v1
kind: Service
metadata:
  name: otel-collector
  namespace: otel-tutorial
spec:
  type: ClusterIP
  selector:
    app: otel-collector
  ports:
    - name: otlp-grpc
      port: 4317
      targetPort: otlp-grpc
    - name: otlp-http
      port: 4318
      targetPort: otlp-http
EOF

cat > jaeger.yaml <<- "EOF"
# Jaeger all-in-one: in-memory storage, traces are lost on restart.
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jaeger
  namespace: otel-tutorial
  labels:
    app: jaeger
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jaeger
  template:
    metadata:
      labels:
        app: jaeger
    spec:
      containers:
        - name: jaeger
          image: jaegertracing/all-in-one:latest
          ports:
            - name: ui
              containerPort: 16686
            - name: otlp-grpc
              containerPort: 4317
            - name: otlp-http
              containerPort: 4318
          resources:
            requests:
              cpu: 50m
              memory: 128Mi
            limits:
              memory: 512Mi
---
apiVersion: v1
kind: Service
metadata:
  name: jaeger
  namespace: otel-tutorial
spec:
  type: ClusterIP
  selector:
    app: jaeger
  ports:
    - name: ui
      port: 16686
      targetPort: ui
    - name: otlp-grpc
      port: 4317
      targetPort: otlp-grpc
    - name: otlp-http
      port: 4318
      targetPort: otlp-http
EOF

cat > prometheus.yaml <<- "EOF"
# Prometheus with the OTLP receiver enabled (push); uses the image's default prometheus.yml.
# Storage is an emptyDir: metrics are lost when the pod is rescheduled.
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus
  namespace: otel-tutorial
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
            - --web.enable-otlp-receiver
          ports:
            - name: http
              containerPort: 9090
          volumeMounts:
            - name: data
              mountPath: /prometheus
          resources:
            requests:
              cpu: 50m
              memory: 256Mi
            limits:
              memory: 1Gi
      volumes:
        - name: data
          emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: prometheus
  namespace: otel-tutorial
spec:
  type: ClusterIP
  selector:
    app: prometheus
  ports:
    - name: http
      port: 9090
      targetPort: http
EOF

cat > loki.yaml <<- "EOF"
# Single-binary Loki using the image's bundled local config (filesystem storage under /loki).
# OTLP logs are ingested at http://loki:3100/otlp. Storage is an emptyDir.
apiVersion: apps/v1
kind: Deployment
metadata:
  name: loki
  namespace: otel-tutorial
  labels:
    app: loki
spec:
  replicas: 1
  selector:
    matchLabels:
      app: loki
  template:
    metadata:
      labels:
        app: loki
    spec:
      securityContext:
        fsGroup: 10001   # Loki image runs as uid 10001; lets it write to the emptyDir
      containers:
        - name: loki
          image: grafana/loki:3.4.2
          args: ["-config.file=/etc/loki/local-config.yaml"]
          ports:
            - name: http
              containerPort: 3100
          volumeMounts:
            - name: data
              mountPath: /loki
          readinessProbe:
            httpGet:
              path: /ready
              port: http
            initialDelaySeconds: 10
            periodSeconds: 10
          resources:
            requests:
              cpu: 50m
              memory: 128Mi
            limits:
              memory: 512Mi
      volumes:
        - name: data
          emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: loki
  namespace: otel-tutorial
spec:
  type: ClusterIP
  selector:
    app: loki
  ports:
    - name: http
      port: 3100
      targetPort: http
EOF

cat > grafana.yaml <<- "EOF"
# Grafana with Loki, Prometheus and Jaeger datasources pre-provisioned.
# Uses the image's default login (admin/admin, change prompted on first login);
# anonymous admin access from the docker-compose setup is intentionally not enabled here.
apiVersion: v1
kind: ConfigMap
metadata:
  name: grafana-datasources
  namespace: otel-tutorial
data:
  datasources.yaml: |
    apiVersion: 1
    datasources:
      - name: Loki
        type: loki
        access: proxy
        url: http://loki:3100
        isDefault: true
      - name: Prometheus
        type: prometheus
        access: proxy
        url: http://prometheus:9090
      - name: Jaeger
        type: jaeger
        access: proxy
        url: http://jaeger:16686
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
  namespace: otel-tutorial
  labels:
    app: grafana
spec:
  replicas: 1
  selector:
    matchLabels:
      app: grafana
  template:
    metadata:
      labels:
        app: grafana
    spec:
      containers:
        - name: grafana
          image: grafana/grafana:latest
          ports:
            - name: http
              containerPort: 3000
          volumeMounts:
            - name: datasources
              mountPath: /etc/grafana/provisioning/datasources
          readinessProbe:
            httpGet:
              path: /api/health
              port: http
            periodSeconds: 10
          resources:
            requests:
              cpu: 50m
              memory: 128Mi
            limits:
              memory: 512Mi
      volumes:
        - name: datasources
          configMap:
            name: grafana-datasources
---
apiVersion: v1
kind: Service
metadata:
  name: grafana
  namespace: otel-tutorial
spec:
  type: ClusterIP
  selector:
    app: grafana
  ports:
    - name: http
      port: 3000
      targetPort: http
EOF