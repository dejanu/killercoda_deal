cat > probe-lab.yaml <<- "EOF"
apiVersion: v1
kind: Pod
metadata:
  name: probe-lab
spec:
  containers:
    - name: app
      image: python:3.12-alpine
      command: ["/bin/sh", "-c"]
      args:
        - |
          echo "Starting app..."
          sleep 15
          python -m http.server 8080
      ports:
        - containerPort: 8080

      livenessProbe:
        httpGet:
          path: /
          port: 8080
        initialDelaySeconds: 3
        periodSeconds: 5

      readinessProbe:
        httpGet:
          path: /
          port: 8080
        initialDelaySeconds: 3
        periodSeconds: 5
EOF

kubectl apply -f probe-lab.yaml