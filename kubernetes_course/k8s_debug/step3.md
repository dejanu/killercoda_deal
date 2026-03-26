
### Debug pod

* you can debug a node by creating an interactive shell session on the target node using `kubectl debug nodes/<nodename> --profile=sysadmin -it --image=<image>`

* `--profile=sysadmin` flag typically sets up the pod with: privileged :true, hostPID: true (for node networking), hostNetwork: true (for process visibility), host filesystem mounted at `/host`

⚠️ To help ensure no vulnerabilities are introduced into the cluster, an easy approach is to use something like [DHI](https://www.docker.com/products/hardened-images/)

* Start debug pod on node1: `kubectl debug nodes/node01 --profile=sysadmin -it --image=alpine:latest`{{copy}}

* Check if `systemctl` binary is available. 

* Next to “switch” from the container filesystem you need to `chroot /host`{{copy}} ; And from there you are effectively in the node’s userland, and you can use the node’s binaries.

* Check if `systemctl` binary is available 😉

⚠️ `kubectl debug` creates a debug pod with a name derived from the node name, so remember to delete the pod once you’re done debugging
