#!/bin/bash

# # pull image
# docker pull dejanualex/dockersay:2.1

# pull deployment
# curl https://raw.githubusercontent.com/dejanu/killercoda_deal/main/course/init_container/deployment.yaml -o deployment.yaml

# create deployment
cat > deploy.yaml <<- "EOF"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      restartPolicy: Always
      volumes:
        - name: data
          emptyDir: {}
      initContainers:
        - name: nginx-init
          image: dejanualex/dockersay:1.0
          command: [sh, -c]
          args: [echo "<pre>$(cowsay -b 'Hello Kubernetes')</pre>" > /data/index.html]
          volumeMounts:
            - name: data
              mountPath: /data
      containers:
        - name: nginx
          image: nginx:1.11
          volumeMounts:
            - name: data
              mountPath: /usr/share/nginx/html
EOF

cat > sidecar_pod.yaml <<- "EOF"
apiVersion: v1
kind: Pod
metadata:
  name: nginx-with-logging-sidecar
spec:
  volumes:
    - name: shared-logs
      emptyDir: {}

  containers:
    - name: nginx
      image: nginx:latest
      ports:
        - containerPort: 80
      volumeMounts:
        - name: shared-logs
          mountPath: /var/log/nginx

  initContainers:
    - name: log-shipper
      image: dejanualex/log-shipper:1.0
      restartPolicy: Always   # <- this makes it a sidecar, not a one-shot init container
      args: ["/var/log/nginx/access.log"]
      volumeMounts:
        - name: shared-logs
          mountPath: /var/log/nginx
EOF