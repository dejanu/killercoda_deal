
<br>

### Setup 

**kubectl** is a command line tool for communicating with a Kubernetes cluster's control plane, using the Kubernetes API.
**kubectl** makes it easier for you to use the Kubernetes API, by simply making the HTTP requests to the appropriate Kubernetes API endpoints: `kubectl api-resources`.

<hr>

For configuration, `kubectl` looks for a file named config in the `$HOME/.kube` directory. You can specify other kubeconfig files by setting the `KUBECONFIG` environment variable or by using the `--kubeconfig` flag.

![Scan results](./assets/kubectl.png)

Explore the cluster configuration `kubect get no`, what happens:
```bash
couldn't get current server API group list
```