
### Secrets

* Secrets: API object that stores sensitive data such as credentials used by Pods, secrets are not encrypted are base64 encoded

* Spin-up nginx pod, by running `kubectl  apply -f deploy.yaml`{{exec}} (give it a few seconds for `deploy.yaml` file to be serialized)

* Wait for the pod to have STATUS Running `kubectl get po`{{exec}} and then forward connection to a local port i.e. 8080 to pod's port 80
`kubectl port-forward $(kubectl  get po -oname) 8080:80 &`{{exec}} (hit ENTER and send it in the background).

* Check the service: `curl localhost:8080`{{exec}}

* Our init container `nginx-init` will write the ascii art to `index.html` that will be served by the main `nginx` container : `kubectl  get deploy/nginx-deployment -oyaml | grep -A20 containers:`{{exec}} 