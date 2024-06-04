#!/bin/bash

# Define the filename
FILENAME="deployment.yaml"

cat << EOF > $FILENAME

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
          image: docker/whalesay
          command: [sh, -c]
          args: [echo "<pre>\$(cowsay -b 'Hello Kubernetes')</pre>" > /data/index.html]
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