## Phase vs. State: CrashLoopBackOff

* Spin up a pod and check its phase: `kubectl run onfail1 --image=alpine --restart=OnFailure -- /bin/sh -c "exit 1"`{{exec}}

* What will be the output of: `kubectl get po -A --field-selector=status.phase!=Running`{{exec}}

* Create a simple nginx deployment: `kubectl  create deployment test --image=nginx`{{exec}} then kill the nginx process inside the container. What happens to the Pod?


<details>
<summary>Hints</summary>

<code>state.waiting.reason</code> exists only when a container is in waiting state, <code>CrashLoopBackOff</code> is a waiting reason.
<code>kubectl get po -A -ojsonpath="{.items[*].status.containerStatuses[*].state.waiting.reason}"</code>

Pods don’t “restart” they only get deleted. Replacement is a controller decision.
When the container in the pod fails, the pod is not restarted.

<code>kubectl  exec test-6bb654b8f8-w4vn6 -- /bin/sh -c 'kill -TERM 1'</code>