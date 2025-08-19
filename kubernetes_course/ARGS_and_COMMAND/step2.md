
### Running commands inside the container

* Start a pod named `nginx` using the nginx latest image
`kubectl run nginx --image=nginx`{{exec}}

* List the directory contents of the container's file-system: `kubectl exec nginx -- ls`{{copy}}

* Start an interactive session inside the container: `kubectl exec -it nginx -- sh`{{copy}}


