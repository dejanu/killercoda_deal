## Static Pod

Create a naked pod named `test`, based on a `ngnix` image, and check on which node is has been scheduled.

* Mandatory fields for Pod object:
```bash
apiVersion - Which version of the Kubernetes API you're using to create this object
kind - What kind of object you want to create
metadata - Data that helps uniquely identify the object, including a name string, UID, and optional namespace
spec - What state you desire for the object
```


<details>
<summary>Hint</summary>
Create naked pod: <code>kubectl run test  --image=nginx</code> and <code>kubectl get no -owide</code>
<br>
Check kubelet status: <code>systemctl status kubelet.service</code> and logs <code>journalctl -xeu kubelet.service</code>
<br>
Check location of kubectl bin <code>which kubectl</code> and fix <code>10-kubeadm.conf</code>
</details>