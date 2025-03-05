
<br>

### WELL DONE !

* `kubectl` reference [here](https://kubernetes.io/docs/reference/kubectl/)

* The `config` file that is used to configure access to a cluster is usually, called kubeconfig ( `~/.kube/config`), but you can easily override the location by using `--kubeconfig <path_to_config>` flag.

* A Kubernetes config file describes clusters, users, and contexts. You can have **multiple** contexts in order to target different Kubernetes **clusters**.

* If you need to get the current context without using `kubect config current-context`{{copy}}, you can also use:
`cat ~/.kube/config | grep -i "current-context" | awk '{print $2}'`{{copy}}

* `config` file fields and structure [here](https://kubernetes.io/docs/reference/config-api/kubeconfig.v1/)
