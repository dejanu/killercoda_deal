
### Volumes: How to achieve persistency in Pods? 

* A **volume** in Kubernetes is a storage abstraction that allows Pods to persist data across container restarts. Volume Types: 

    `emptyDir` - temporary storage that lasts as long as the pod runs.
    `hostPath` - uses a directory on the host node.
    `PVC` - uses `PV` for durable storage.

* Create the follwing ngnix based deployments, create a file under `/usr/share/nginx/html` and check if it's persisted in both cases `ls /usr/share/nginx/html`. Delete the pods and check once more if the file is persisted.

```bash
# create a vanilla nginx deployment
kubectl apply -f deployment_without_volume.yaml

# create a ngnix deployment that mounts a volume 
kubectl apply -f deployment_volume.yaml

# exec in each pod and create a file /usr/share/nginx/html
kubectl exec -it pods/nginx-with-volume-d556bf558-86mwc -- sh
kubectl exec -it pods/nginx-without-volume--6c764b4cb-bbh6g -- sh 

# delete both pods
kubectl  delete po --all

# check the file in each new pod
kubectl exec nginx-without-volume--6c764b4cb-bbh6g -- ls /usr/share/nginx/html
kubectl exec nginx-with-volume-d556bf558-mwtwg -- ls /usr/share/nginx/html
```

* Create a new depoyment `kubectl apply -f deployment_emptydir.yaml`{{copy}} and inspect the containers
`kubectl get po -ojsonpath="{.spec.containers[*].name}{'\n'}" emptydir-deployment-f8756b8c7-g24f9 `{{copy}}
How many containers are in the pod, what does each one log?

```bash
kubectl logs --all-containers emptydir-deployment-7dcbd4cdfc-q952s
```

* When to use `emptyDir` and when to use `hostPath`?

<details>
<summary>Hint</summary>
<code>kubectl logs emptydir-deployment-7dcbd4cdfc-q952s -c app-container</code> and also <code>kubectl logs emptydir-deployment-7dcbd4cdfc-q952s -c sidecar-container</code>
<br>
<b>emptyDir</b>: used for Temporary storage (caching/buffers, shared files between containers of the same Pod) at the pod level. 
<br>
<b>hostPath</b>: when you need direct access to a host machine's filesystem (custom monitoring agents, storing accessign logs on node /var/log)
</details>