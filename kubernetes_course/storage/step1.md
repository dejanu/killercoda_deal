
### Volumes

* A volume in Kubernetes is a storage abstraction that allows Pods to persist data across container restarts

* Types:

     `emptyDir` - temporary storage that lasts as long as the pod runs
     `hostPath` - uses a directory on the host node
     `PVC` - uses `PV` for durable storage


* How to achieve persistency in Pods? Create the follwing ngnix based deployments, create a file under `/usr/share/nginx/html` and check if it's persisted in both cases `ls /usr/share/nginx/html`. Delete the pods   What is the difference ?

```bash
# create a vanilla nginx deployment
kubectl apply -f deployment_without_volume.yaml

# create a ngnix deployment that mounts a volume 
kubectl apply -f deployment_volume.yaml

# you have bash in the pod
kubectl exec local-web-1283712-fsdf -- ls /usr/share/nginx/html

# delete po
kubectl delete po nginx-deployment-... local-web-...
```

* Create a new depoyment `kubectl apply -f deployment_emptydir.yaml`{{copy}} and inspect the container. Which pod logs what?

```bash
kubectl get deployment ....
kubectl logs --all-containers emptydir-deployment-7dcbd4cdfc-q952s
```

* When to use `emptyDir` and when to use `hostPath`?

<details>
<summary>Hint</summary>
<code>kubectl logs emptydir-deployment-7dcbd4cdfc-q952s -c app-container</code> and also <code>kubectl logs emptydir-deployment-7dcbd4cdfc-q952s -c sidecar-container</code>
<br>
<b>emptyDir</b> used for Temporary storage (e.g. caching/buffers, shared files between containers of the same Pod) at the pod level. 
<br>
<b>hostPath</b> when you need direct access to a host machine's filesystem (custom monitoring agents, storing accessign logs on node /var/log)
</details>