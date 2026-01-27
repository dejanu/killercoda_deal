## Phase vs. State: CrashLoopBackOff

* Spin up a pod and check its phase: `kubectl run onfail1 --image=alpine --restart=OnFailure -- /bin/sh -c "exit 1"`{{exec}}

* What will be the output of: `kubectl get po -A --field-selector=status.phase!=Running`{{exec}}

* Create a simple nginx deployment: `kubectl  create deployment test --image=nginx`{{exec}} 

<details>
<summary>Hints</summary>

<code>state.waiting.reason</code> exists only when a container is in waiting state, <code>CrashLoopBackOff</code> is a waiting reason.

