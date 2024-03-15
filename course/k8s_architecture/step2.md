
### Control plane

* Currently we're on the controlplane node. Each control plane node runs an instance of the `kube-apiserver`, `kube-scheduler`, and `kube-controller-manager` and `ectd`.

* When `etcd` runs in the cluster's control-plane nodes we're dealing with a stacked etcd topology, in contrast to configurations where etcd is external to the cluster.

* A stacked HA cluster architecture:

![Scan results](./assets/stacked_etcd.png)

* `kubelet` is the primary "node-agent" that runs on each node (`which kubelet`{{exec}}), running as a service in the OS, to check its status just: `systemctl status kubelet.service`{{exec}}

* The `kubelet` service needs to be up and running permanently. This way it will be able to execute pod requirements (take any new PodSpec definition from the Kubernetes API as soon as the Pod is scheduled to run on the node), manage resources and register a node with the *apiserver* (if needed).

* If the `kubelet` is not working properly, has crashed, or it is down for any reason, the Kubernetes node will go into a **NotReady** state, and no new pods will be created on that node.








