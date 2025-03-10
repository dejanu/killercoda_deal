
### Volumes

* A volume in Kubernetes is a storage abstraction that allows Pods to persist data across container restarts

* Types:

     `emptyDir` - temporary storage that lasts as long as the pod runs
     `hostPath` - uses a directory on the host node
     `PVC` - uses `PV` for durable storage


* How to achieve persistency in Pods? Create ngnix deployments, create a file under `ls /usr/share/nginx/html` and check if it's persisted in both cases. What is the difference ?

```bash
# create a vanilla nginx deployment
kubectl apply -f deployment_without_volume.yaml

# create a ngnix deployment that mounts a volume 
kubectl apply -f deployment_volume.yaml
```

```bash
# ....
kubectl exec local-web-1283712-fsdf -- ls /usr/share/nginx/html
```

# create po that read the file (mounted as volume)
kubectl apply -f secrets_ephemeral.yaml
# should the pod logs (which is a job due to restartpolicy): what does it output? see that logs output the secret
kubectl logs secret-pod 
```

* Create the following deployment `kubectl apply -f deployment_emptydir.yaml`{{copy}}


* When to use `emptyDir` and when to use `hostPath`?

<details>
<summary>Hint</summary>
Create secrets: <code>kubectl create secret generic user-secret --from-literal=user=root</code> and <code>kubectl create secret generic password-secret --from-file=./pass.txt</code>
<br>
emptyDir used for Temporary storage (e.g., caching/buffers, shared files between containers of the same Pod) at the pod level. 
<br>
hostPath when you need direct access toa  host machine's filesystem (custom monitoring agents, storing accessign logs on node /var/log)
</details>