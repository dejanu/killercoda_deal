
### Volumes

* A volume in Kubernetes is a storage abstraction that allows Pods to persist data across container restarts

* Types:

     `emptyDir` - temporary storage that lasts as long as the pod runs
     `hostPath` - uses a directory on the host node
     `PVC` - uses `PV` for durable storage


* Create a pod that mounts a volume:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: local-web
spec:
  replicas: 1
  selector:
    matchLabels: 
      app: local-web
  template:
    metadata:
      labels:
        app: local-web
    spec:
      containers:
      - name: local-web
        image: nginx
        ports:
          - name: web
            containerPort: 80
        volumeMounts: 
          - name: webvolume
            mountPath: /usr/share/nginx/html # location in the container
      volumes: # specify the volume that the pod will use
      - name: webvolume
        hostPath: # mounts a dir from the host NODE filesystem
          path: /var/nginxserver
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