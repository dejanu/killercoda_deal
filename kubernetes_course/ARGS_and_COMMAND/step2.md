
### Default start

* Start a pod named `nginx` using the nginx latest image
`kubectl run nginx --image=nginx`{{exec}}

* Start an interactive session inside the container: `kubectl exec -it nginx -- sh`{{copy}}

* List the directory contents of the container's file-system: `kubectl exec nginx -- ls`{{copy}}
