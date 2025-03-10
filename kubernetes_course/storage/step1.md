
### Secrets and Config Maps

* Secrets: K8S object that stores sensitive data such as credentials used by Pods, secrets are not **encrypted**, they are base64 encoded. A secret is an object that contains a small amount of sensitive data such as a password, a token, or a key

* Creating secrets:

```bash
# create secrets
kubectl create secret generic user-secret --from-literal=user=root
kubectl create secret generic password-secret --from-file=./pass.txt

# show the secret {"user":"cm9vdA=="} and decode
kubectl get secrets user-secret -ojsonpath={.data} 
kubectl get secrets user-secret -ojsonpath={.data.user} | base64 -d

# create po that read the file (mounted as volume)
kubectl apply -f secrets_ephemeral.yaml
# should the pod logs (which is a job due to restartpolicy): what does it output? see that logs output the secret
kubectl logs secret-pod 
```