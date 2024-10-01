## Backup etcd


Create and store the a `etcd` backup. To back up `etcd` in a Kubernetes cluster, you can use the built-in `etcdctl` command-line tool.

**etcd** runs as a pod in the control plane `kubectl -n kube-system get po`{{copy}}, more exactly as a static-pod `/etc/kubernetes/manifests/etcd`


