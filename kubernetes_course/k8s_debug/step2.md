
### Running commands inside the container

* Create a deployment based on `nginx` latest image
`kubectl create deployment nginx --image=nginx`{{exec}}

* List the directory contents of the container's file-system: `kubectl exec nginx -- ls`{{copy}}

* Start an interactive session inside the container: `kubectl exec -it nginx -- sh`{{copy}}. Check if you have `nslookup` binary inside the container.

* Get the pod name of the `nginx` deployment: `kubectl get pods`{{copy}} and the container name: `kubectl  get po nginx-... -ojsonpath="{.spec.containers[*].name} "`

⚠️ Start a debug container/session command: `kubectl debug -it POD --image=IMAGE --target=CONTAINER`

* Start a debug container/session and attach it to the running `nginx` pod: `kubectl debug nginx-...--image=busybox -it --target=nginx -- sh` and check if you have `nslookup` inside the **debug container**
