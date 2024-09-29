
<br>

### Setup 

`kubectl` is a command line tool for communicating with a Kubernetes cluster's control plane, using the Kubernetes API.

<hr>

For configuration, `kubectl` looks for a file named config in the `$HOME/.kube` directory. You can specify other kubeconfig files by setting the `KUBECONFIG` environment variable or by setting the `--kubeconfig` flag.

![Scan results](./assets/kubectl.png)

Explore the cluster configuration `kubect get no`, what happens:
```bash
couldn't get current server API group list
```