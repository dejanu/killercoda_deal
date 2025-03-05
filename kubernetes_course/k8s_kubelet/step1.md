## Fix NotReady node

* `kubelet` is node agent that runs as a daemon, thus being maintaned by a init system like `systemd`, more precisely Kubelet's behavior is managed by a systemd unit file.

Check cluster: `kubectl get no -owide` what are you observing? Try to spin-up a pod: `kubectl run test --image=nginx`{{exec}}. What happens? `kubect get po`{{exec}}

* ssh into `ssh node01`{{exec}} the worker node and try to find why the node is NodeReady.

* the kubelet has a main service definition `/lib/systemd/system/kubelet.service`{{copy}} and to further customize `kubelet.service.`
the `kubeadm` writes a drop-in configuration file at `/usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf` which is used by systemd. 

<details>
<summary>Hint</summary>
Get name: <code>kubectl describe no node01</code>
<br>
Check kubelet status: <code>systemctl status kubelet.service</code> and logs <code>journalctl -xeu kubelet.service</code>
<br>
Check location of kubectl bin <code>which kubectl</code> and fix <code>10-kubeadm.conf</code>
<br>
Dont forget <code>systemctl restart kubelet.servic</code> & <code>systemctl daemon-reload</code>
</details>