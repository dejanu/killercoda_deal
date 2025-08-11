## Probes and RestartPolicy

* A Pod's status field is a `PodStatus` object, which has a [phase](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase) field: `kubectl explain po.status.phase`{{exec}}:

```bash
Pending: Pod waiting to be scheduled as well as the time spent downloading container images
Running: Pod bound to a node 
Failed: All containers in the Pod have terminated and at lest one container has terminated in failure.
Unknown: The state of the Pod could not be obtained
```

* How to handle container failures? 
The restart policy for a Pod, legal values **[Always, OnFailure, Never]**.
There's also a spec for `restartPolicy` `kubectl explain po.spec.restartPolicy`{{exec}}

Create a deployment `kubectl create deploy alpine-test --image=alpine`{{exec}}, check the pods? What is happening and why?

```bash
# Never: does not restart the container: Completed
kubectl run never --image=alpine --restart=Never  -- echo "Hello"

# OnFailure: only restart the container if it exits with an non-zero exit otherwise: Completed
kubectl run onfail --image=alpine --restart=OnFailure  -- echo "Hello"

# OnFailOnFailure:  "exit": executable file not found in $PATH: unknown: CrashLoopBackOff 
kubectl run onfail1 --image=alpine --restart=OnFailure -- /bin/sh -c "exit 1"

# Always (DEFAULT): k8s will try to restart the pod if it fails or even if is: Completed.
kubectl run always --image=alpine --restart=Always  -- echo "Hello"
```

<details>
<summary>Hints</summary>
Always is the default policy <code>kubectl get po ... -oyaml | grep restartPolicy</code>
<br>

</details>
