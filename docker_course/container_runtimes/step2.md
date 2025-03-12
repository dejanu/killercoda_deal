## Benefits of OCI

![Scan results](./assets/crictl.png)


* Pulling an image using docker CLI `docker image pull docker.io/dejanualex/dockersay:2.0`{{copy}}

* Or with another CLI: `crictl pull docker.io/dejanualex/dockersay:2.0`{{copy}} and  check`crictl images`{{copy}}

* `crictl` uses the CRI to interface with containerd and can be used without any Kubernetes components. Usually is designed as a CLI for kubelet CRI: `crictl pods`{{copy}}
