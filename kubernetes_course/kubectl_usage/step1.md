## Setup

For configuration, `kubectl` looks for a file named `config` in `$HOME/.kube` directory. You can specify other kubeconfig files by setting the `KUBECONFIG` environment variable or by using the `--kubeconfig` flag.

Explore the cluster configuration `kubectl get no`, what happens:
```bash
couldn't get current server API group list...
```
Increase the verbosity: `kubectl get no -v=6` and look for `Config loaded from file` 

kubectl `config` file stores all the information necessary to interact with a Kubernetes cluster:
- The name of the Kubernetes cluster: `kubectl config current-context`{{copy}}
- The location of the Kubernetes API server: `kubectl config get-clusters`{{copy}} 
- The credentials (username and password) for authenticating with the Kubernetes API server: `kubectl config get-users`{{copy}} 
- The names of all contexts defined in the cluster (a **context** is a combination of a cluster and user credentials): `kubectl config get-contexts`{{copy}} 
 
<details>
<summary>⚠️ Solution</summary>
Move back the original config: <code>mv ~/.kube/bkp.config ~/.kube/config</code>
<br>
Change the context: <code>kubectl config use-context <context_name></code>
<br>
</details>
