#!/bin/bash

# create secret file
cat > pass.txt <<- "EOF"
dummy
EOF

# create deployment that mounts volume
cat > deployment.yaml <<- "EOF"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: local-web
spec:
  replicas: 1
  selector:
    matchLabels: 
      app: local-web
  template:
    metadata:
      labels:
        app: local-web
    spec:
      containers:
      - name: local-web
        image: nginx
        ports:
          - name: web
            containerPort: 80
        volumeMounts: 
          - name: webvolume
            mountPath: /usr/share/nginx/html # location in the container
      volumes: # specify the volume that the pod will use
      - name: webvolume
        hostPath: # mounts a dir from the host NODE filesystem
          path: /var/nginxserver
EOF