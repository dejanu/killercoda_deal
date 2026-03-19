## Debug the current pod

* Check pod status , inspect events

```bash

kubectl get pods
kubectl describe pod probe-lab
kubectl logs probe-lab --previous
```

<details>
<summary>Hints</summary>
Always (DEFAULT): k8s will try to restart the pod if it fails or even if is: Completed <code>kubectl get po ... -oyaml | grep restartPolicy</code>
<br>

Never: does not restart the container: Completed or Error
<br>

OnFailure: restart the container ONLY if it exits with an non-zero exit otherwise: Completed
<br>

</details>
