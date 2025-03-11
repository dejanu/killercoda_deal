## Probes and RestartPolicy

* Liveness probes determine when to restart a container.

* Readiness probes determine when a container is ready to start accepting traffic.

* Startup Probe (if configured), it disables liveness and readiness checks until it succeeds, is only executed at startup, unlike liveness and readiness probes, which are run periodically.

Create a pod without any probes and add liveness probe: `kubectl run nginxpod --image=nginx --port 80 --dry-run=client -oyaml | tee  po.yaml`{{copy}} do a `kubectl apply -f po.yaml`{{copy}} , create the following pod with a **liveness probe**. What happens ?

Add livenessProbe section:
```yml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
  namespace: ca1
spec:
  containers:
  - image: nginx
    name: nginx
    ports:
    - containerPort: 80
    livenessProbe:
      httpGet:
        path: /
        port: 8080
      initialDelaySeconds: 10
      periodSeconds: 5
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```
<details>
<summary>Hint</summary>
The container gets restarted 
<br>
Fix the port <code>kubect edit deployment ...</code>
<br>
</details>

