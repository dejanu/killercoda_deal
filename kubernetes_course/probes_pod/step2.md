## Probes and RestartPolicy

* Liveness probes determine when to restart a container.

* Readiness probes determine when a container is ready to start accepting traffic.

* Startup Probe (if configured), it disables liveness and readiness checks until it succeeds, is only executed at startup, unlike liveness and readiness probes, which are run periodically.

Create a pod without any probes and add liveness probe: `kubectl run nginxpod --image=nginx --port 80 --dry-run=client -oyaml | tee  po.yaml`{{copy}} do a `kubectl apply -f po.yaml`{{copy}}, inspect the pod, check if it has any probes? Delete the po

create the following pod with `kubectl apply -f pod.yaml`{{copy}}. What happends?

```bash
cat<<EOF>>pod.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
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
EOF
```{{exec}}

<details>
<summary>Hint</summary>
The container gets restarted 
<br>
 By default k8s allows 3 consecutive failureThreshold, so after 10sec we have 3 probes amounting to 15sec so after ~30sec the pod will be restarted,
 <br>
 Fix port update `port: 80` (from 8080 to 80) and `kubectl delete -f po.yaml` and `kubectl apply -f po.yaml`
<br>
</details>

