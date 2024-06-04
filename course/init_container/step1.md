
### Init Container

* We're going to see a simple use cause of a **init-container** that generates the HTML file that will be served by the main container.

* Spin-up nginx pod, by running `kubectl  apply -f deployment.yaml`{{exec}}

```yaml

```

* Wait for the pod to have STATUS Running `kubectl get po`{{exec}} and then perform forward connection to a local port i.e. 8080 to pod's port 80
`kubectl port-forward $(kubectl  get po -oname) 8080:80 &`{{exec}} (hit ENTER and send it in the background)
