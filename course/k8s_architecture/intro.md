
<br>

### Components 

* A Kubernetes cluster has two main components the **control plane** and the **data plane**

* Control-plane, includes:

    * [etcd](https://etcd.io/): a consistent and highly-available key value store used as Kubernetes backing store for all cluster data.
    * API Server: component of the Kubernetes control plane that exposes the Kubernetes API.
    * Scheduler: the component that schedules workload to worker nodes, watches newly created Pods, and selects a node for them to run on.
    * Controller Manager: the component that runs controller processes.
    * Cloud Controller Manager: the component that embeds cloud-specific control logic.

⚠️ The aforementioned components can be run as traditional operating system services (daemons) or as containers on the  control-plane nodes.

* Data plane:

    * A set of **worker** nodes that run your workload by placing containerized workloads into Pods, and most importantly contains the services necessary to run Pods: `kubelet`, `kube-proxy`, and `container-runtime` (implementing the Container Runtime Interface).





