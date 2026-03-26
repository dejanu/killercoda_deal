
### Running commands inside the container

* Start a pod named `nginx` using the nginx latest image
`kubectl run nginx --image=nginx`{{exec}}

* List the directory contents of the container's file-system: `kubectl exec nginx -- ls`{{copy}}

* Start an interactive session inside the container: `kubectl exec -it nginx -- sh`{{copy}}. Check if you have `nslookup` binary inside the container.

* Start a debug container/session and attach it to the running `nginx` pod: `kubectl debug nginx --image=busybox -it --target=nginx -- sh` and check if you have `nslookup` inside the **debug container**
