
### Secrets and Config Maps

* **Secrets**: K8S object that stores sensitive data such as credentials used by Pods, secrets are not **encrypted**, they are base64 encoded. A secret is an object that contains a small amount of sensitive data such as a password, a token, or a key

* Create a secret called `user-secret` with key `user` and value `root` (from key-value pair) and another one called `password-secret` (from file `pass.txt`), aftwerwards create pod `kubectl apply -f secrets_env.yaml`. What secret does `secret-pod` uses?

```bash
# create po that read the file (mounted as volume)
kubectl apply -f secrets_env.yaml

# inspect po 
kubectl  get po secret-pod -oyaml

# what write to stdout
kubectl logs secret-pod 

# recreate the po 
kubectl delete po secret-pod 
kubectl apply -f secrets_volume.yaml

# show the secrets: {"user":"cm9vdA=="} and decode
kubectl get secrets user-secret -ojsonpath={.data.user} | base64 -d
kubectl get secrets password-secret -ojsonpath="{.data.pass\.txt}" | base64 -d
```



* **ConfigMap** K8S object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.

```bash
# create config maps
kubectl create configmap special-cm --from-literal=special=very --from-literal=type=charm
kubectl get configmaps special-cm -oyaml
kubectl get configmaps special-cm -ojsonpath="{.data}"
```

<details>
<summary>Hint</summary>
Create secrets: <code>kubectl create secret generic user-secret --from-literal=user=root</code> and <code>kubectl create secret generic password-secret --from-file=./pass.txt</code>
<br>
Get po as yaml: <code>kubectl get po test -oyaml > pod.yaml</code> and remove **non-mandatory** fields.
<br>
Place the file at <code>/etc/kubernetes/manifests/kube-pod.yaml</code>
</details>