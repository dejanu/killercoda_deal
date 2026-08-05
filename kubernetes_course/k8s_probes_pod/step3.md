## Phase vs. State: CrashLoopBackOff

* Spin up a pod `onfail1` pod: `kubectl run onfail1 --image=alpine --restart=OnFailure -- /bin/sh -c "exit 1"`{{exec}}

* What will be the output of: `kubectl get pods`{{copy}} vs `kubectl get po -A --field-selector=status.phase!=Running`{{exec}}

* Phase is a summary of the pod lifecycle: `kubectl  explain po.status.phase`{{copy}} vs. STATUS (column) which is a computation done on the fly by kubectl (the client).

⚠️ When a pod is in `CrashLoopBackOff` or `Error` its `status.phase` is actually **running** , because the pod has been scheduled, bound to a node, and Kubernetes is actively tring to keep it running by restarting the failing container.

* Create a simple nginx deployment: `kubectl  create deployment test --image=nginx`{{exec}} then kill the nginx process inside the container. What happens to the Pod?

* Check `probe-lab` pod details: `kubectl describe pod probe-lab`{{exec}} . What does the events section tell us?

* We need to wait for liveness/readiness until startup succeeds.

```bash
kubectl get pods
kubectl describe pod probe-lab
kubectl logs probe-lab --previous
```


<details>
<summary>Hints</summary>

<code>state.waiting.reason</code> exists only when a container is in waiting state, <code>CrashLoopBackOff</code> is a waiting reason.
<code>kubectl get po -A -ojsonpath="{.items[*].status.containerStatuses[*].state.waiting.reason}"</code>

kill nginx process inside the container: `kubectl  exec test-6bb654b8f8-w4vn6 -- /bin/sh -c 'kill -TERM 1` 

Pods do not RESTART; containers inside the Pod are restarted by the kubelet. 

Pods themselves can be DELETED or RESCHEDULED (i.e. if a node fails), and their replacement is handled by a controller. When a container in a Pod fails, the Pod is not rescheduled—the container is simply restarted in place.

Save the pod manifest and add startupProbe is holding the liveness and readiness probes until it succeeds:  
```
     startupProbe:
        httpGet:
          path: /
          port: 8080
        initialDelaySeconds: 1
        periodSeconds: 3
        failureThreshold: 6
```