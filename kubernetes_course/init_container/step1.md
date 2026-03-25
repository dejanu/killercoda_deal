
### Init container


* Spin-up nginx pod, by running `kubectl  apply -f deploy.yaml`{{exec}} (give it a few seconds for `deploy.yaml` file to be serialized)

* Wait for the pod to have STATUS Running `kubectl get po`{{exec}} 


* Forward connection to a local port i.e. 8080 to pod's port 80
`kubectl port-forward $(kubectl  get po -oname) 8080:80 &`{{copy}} (hit ENTER and send it in the background).

* Call the service: `curl localhost:8080`{{exec}}

* Describe what happens in the pod: `kubectl describe deploy nginx-deployment`{{exec}} , `kubectl  describe po nginx-deployment-xxxx`{{copy}}, `kubectl get deploy/nginx-deployment -oyaml | grep -A10 containers:`{{copy}}

<details>

Our init container `nginx-init` will write the ascii art to `index.html` that will be served by the main `nginx` container, the sequence of events is as follows:

<br>

0. Shared emptyDir volume named data (lives for the lifetime of the Pod)
1. Pod starts
2. initContainer runs → generates HTML file
3. initContainer exits
4. nginx container starts: mounts same volume at /usr/share/nginx/html
5. nginx serves generated file.
</details>