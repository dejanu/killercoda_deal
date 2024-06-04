
### Init Container

* We're going to see a simple use cause of a **init-container** that writes the desired  HTML `index.html` to the mounted volume.

* Spin-up nginx pod, by running `kubectl  apply -f deployment.yaml`{{exec}} (give it a few seconds for `deployment.yaml` file to be serialized)

* Wait for the pod to have STATUS Running `kubectl get po`{{exec}} and then forward connection to a local port i.e. 8080 to pod's port 80
`kubectl port-forward $(kubectl  get po -oname) 8080:80 &`{{exec}} (hit ENTER and send it in the background).

* Check the service: `curl localhost:8080`{{exec}}

* Our init container `nginx-init` will write the ascii art to `index.html` that will be served by the main `nginx` container : `kubectl  get deploy/nginx-deployment -oyaml | grep -A20 containers:`{{exec}} 