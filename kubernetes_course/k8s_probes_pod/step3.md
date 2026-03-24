## Phase vs. State: CrashLoopBackOff

* Spin up a pod and check its phase: `kubectl run onfail1 --image=alpine --restart=OnFailure -- /bin/sh -c "exit 1"`{{exec}}

* What will be the output of: `kubectl get po -A --field-selector=status.phase!=Running`{{exec}}

* Create a simple nginx deployment: `kubectl  create deployment test --image=nginx`{{exec}} then kill the nginx process inside the container. What happens to the Pod?


* Check pod status, inspect events: `kubectl get pods`{{exec}} and `kubectl describe pod probe-lab`{{exec}}

* startupProbe is holding liveness/readiness until startup succeeds

```bash
kubectl get pods
kubectl describe pod probe-lab
kubectl logs probe-lab --previous
```



<details>
<summary>Hints</summary>

<code>state.waiting.reason</code> exists only when a container is in waiting state, <code>CrashLoopBackOff</code> is a waiting reason.
<code>kubectl get po -A -ojsonpath="{.items[*].status.containerStatuses[*].state.waiting.reason}"</code>

Pods do not RESTART; containers inside the Pod are restarted by the kubelet. Pods themselves can be DELETED or RESCHEDULED (i.e. if a node fails), and their replacement is handled by a controller. When a container in a Pod fails, the Pod is not rescheduled—the container is simply restarted in place.


```
     startupProbe:
        httpGet:
          path: /
          port: 8080
        initialDelaySeconds: 1
        periodSeconds: 3
        failureThreshold: 6
```

<code>kubectl  exec test-6bb654b8f8-w4vn6 -- /bin/sh -c 'kill -TERM 1'</code>