
### Secrets and Config Maps

* Secrets: K8S object that stores sensitive data such as credentials used by Pods, secrets are not **encrypted**, they are base64 encoded. A secret is an object that contains a small amount of sensitive data such as a password, a token, or a key

* Creating a secret called `user-secret` (from key-value pair) and another one called `password-secret` (from file `pass.txt`)

```bash
# show the secrets: {"user":"cm9vdA=="} and decode
kubectl get secrets user-secret -ojsonpath={.data} 
kubectl get secrets user-secret -ojsonpath={.data.user} | base64 -d
```


# create po that read the file (mounted as volume)
kubectl apply -f secrets_ephemeral.yaml
# should the pod logs (which is a job due to restartpolicy): what does it output? see that logs output the secret
kubectl logs secret-pod 
```

<details>
<summary>Hint</summary>
Create secrets: <code>kubectl create secret generic user-secret --from-literal=user=root</code> and <code>kubectl create secret generic password-secret --from-file=./pass.txt</code>
<br>
Get po as yaml: <code>kubectl get po test -oyaml > pod.yaml</code> and remove **non-mandatory** fields.
<br>
Place the file at <code>/etc/kubernetes/manifests/kube-pod.yaml</code>
</details>