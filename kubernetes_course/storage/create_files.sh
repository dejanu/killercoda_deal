#!/bin/bash

# create secret file
cat > pass.txt <<- "EOF"
dummy
EOF

# create deployment
cat > deployment_without_volume.yaml <<- "EOF"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 1
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
EOF

# create deployment that mounts volume
cat > deployment_volume.yaml <<- "EOF"
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


# create deployment that uses emptyDir
cat > deployment_emptydir.yaml <<- "EOF"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: emptydir-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: emptydir-app
  template:
    metadata:
      labels:
        app: emptydir-app
    spec:
      volumes:
      - name: cache-volume
        emptyDir: {}  # Temporary shared storage

      containers:
      - name: app-container
        image: busybox
        command: ["sh", "-c", "echo 'Log data' >> /cache/logs.txt && sleep 3600"]
        volumeMounts:
        - mountPath: /cache
          name: cache-volume

      - name: sidecar-container
        image: busybox
        command: ["sh", "-c", "cat /cache/logs.txt && sleep 3600"]
        volumeMounts:
        - mountPath: /cache
          name: cache-volume
EOF

cat > secrets_env.yaml <<- "EOF"
apiVersion: v1
kind: Pod
metadata:
  name: secret-pod
spec:
  containers:
    - name: test-container
      image: busybox
      command: ["sh", "-c", "echo user $DB_USER and passowrd echo $DB_PASS && sleep 3600"]
      env:
        - name: DB_USER
          valueFrom:
            secretKeyRef:
              name: user-secret # name of the secret
              key: user # key in the secret
        - name: DB_PASS
          valueFrom:
            secretKeyRef:
              name: password-secret # name of the secret
              key: pass.txt # key in the secret
  restartPolicy: Never
EOF


cat > secrets_volume.yaml <<- "EOF"
apiVersion: v1
apiVersion: v1
kind: Pod
metadata:
  name: secret-pod
spec:
  volumes:
    - name: secret-volume
      secret:
        secretName: password-secret
  containers:
    - name: test-container
      image: busybox
      command:
        - cat
        - "/etc/secret-volume/pass.txt" # read the file (mounted as volume)
      volumeMounts:
        - name: secret-volume
          readOnly: true
          mountPath: "/etc/secret-volume"
  restartPolicy: Never
  EOF