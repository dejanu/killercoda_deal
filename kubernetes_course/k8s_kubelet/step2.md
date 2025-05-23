## Static Pod

Create a naked pod named `test`, based on a `ngnix` image, and check on which node is has been scheduled.

StaticPods are managed directly by the kubelet daemon on a specific node (are always bound to one to one Kubelet on a specific node).
The API server cannot delete or modify static pods directly.

* Mandatory fields for Pod object:
```
apiVersion
    Which version of the Kubernetes API you're using to create this object
kind 
    What kind of object you want to create
metadata 
    Data that helps uniquely identify the object, including a name string, UID, and optional namespace
spec 
    What state you desire for the object
```

Delete the pod, and recreate it as a static pod on the control-plane node. Static pods always have a `-${NODENAME}` appended to their name, indicating which node controls the static pod.

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: test
  name: test
  namespace: default
spec:
  containers:
  - image: nginx
    imagePullPolicy: Always
    name: test
    resources: {}
```

<details>
<summary>Hint</summary>
Create naked pod: <code>kubectl run test --image=nginx</code> and <code>kubectl get po -owide</code>
<br>
Get po as yaml: <code>kubectl get po test -oyaml > pod.yaml</code> and remove <b>non-mandatory</b> fields.
Or better <code>kubectl run test --image=nginx --dry-run=client -oyaml > kube-pod.yaml</code>
<br>
Place the file at <code>/etc/kubernetes/manifests/kube-pod.yaml</code>
</details>