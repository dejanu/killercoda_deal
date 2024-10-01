
<br>

### WELL DONE !

* [etcd documentation](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster)

* A snapshot may either be created from a live member with the etcdctl snapshot save command or by copying the member/snap/db file from an etcd data directory that is not currently used by an etcd process.

* The `--data-dir=/var/lib/etcd` flag in the etcd manifest specifies the directory on the host where etcd stores its persistent data: `/var/lib/etcd/member/snap/db` (default)