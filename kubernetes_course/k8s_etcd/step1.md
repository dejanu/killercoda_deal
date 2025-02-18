## Backup etcd

Create and store the a `etcd` backup. To back up `etcd` in a Kubernetes cluster, you can use the built-in `etcdctl` command-line tool.

**etcd** runs as a pod in the control plane `kubectl -n kube-system get po`{{copy}}, more exactly as a static-pod `/etc/kubernetes/manifests/etcd.yaml`

Try the CLI: `kubectl  -n kube-system exec etcd-controlplane -- etcdctl --help`{{copy}}

Plain-simple one needs to run, but with proper [options](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#snapshot-using-etcdctl-options) to establish a secure, authenticated, and encrypted connection to the etcd server:
```bash
ETCDCTL_API=3 etcdctl --endpoints $ENDPOINT snapshot save snapshot.db
```

* `ETCDCTL_API=3`: Specifies the version of the etcd API to use (v3 in this case)
* `--endpoints=https://127.0.0.1:2379`: etcd is not hosted outside of the cluster and is running on the default port
* `--cacert=/etc/kubernetes/pki/etcd/ca.crt`: path to Certificate Authority (CA) to validate etcd server's cert
* `--cert=/etc/kubernetes/pki/etcd/server.crt`: path to client certificate for autht of etcd server
* `--key=/etc/kubernetes/pki/etcd/server.key`: path to client private key

Inspect the manifest `grep "command" -A20  /etc/kubernetes/manifests/etcd.yaml `:
```yaml
--peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
--peer-key-file=/etc/kubernetes/pki/etcd/peer.key
--peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt # secure communicatio between nodes (peers)
--trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt # secure communication between clients and etcd server
```

Thus the final command will look:
```bash
kubectl -n kube-system exec etcd-controlplane -- sh -c "ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/peer.crt --key=/etc/kubernetes/pki/etcd/peer.key snapshot save /var/lib/etcd/snap.db"
```{{copy}}

Verify the snapshot:

```bash
kubectl exec -it etcd-controlplane -n kube-system -- etcdctl --write-out=table snapshot status /var/lib/etcd/snap.db
```{{copy}}
