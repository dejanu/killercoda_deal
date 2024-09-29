## Setup

For configuration, `kubectl` looks for a file named config in the `$HOME/.kube` directory. You can specify other kubeconfig files by setting the `KUBECONFIG` environment variable or by using the `--kubeconfig` flag.

Explore the cluster configuration `kubect get no`, what happens:
```bash
couldn't get current server API group list
```
Increase the verbosity: `kubectl get no -v=6` and look for `Config loaded from file` 

kubectl `config` file stores all the information necessary to interact with a Kubernetes cluster:
- The name of the Kubernetes cluster
- The location of the Kubernetes API server
- The credentials (username and password) for authenticating with the Kubernetes API server
- The names of all contexts defined in the cluster


* A **context** is a combination of a cluster and user credentials.

⚠️ Hints: 

* Check current configuration `kubectl config view`{{copy}} 
* Check current context `kubectl config current-context`{{copy}}
* Check clusters: `kubectl config get-clusters`{{copy}} and users `kubectl config get-users`{{copy}}
* Try to change the context: `kubectl config use-context <context_name>`{{copy}}