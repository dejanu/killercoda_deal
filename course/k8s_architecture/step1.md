
### 101

* Running `kubectl get nodes -owide`{{exec}} will give us a general idea about the cluster size, and the number of workers and master nodes.

* Kubernetes architecture is fully API-driven, the API Server is the core of Kubernetes’s control-plane, to inspect it we can enhance the verbosity level of `kubectl`
`kubectl get no -v=8`{{exec}} in order to take a look at the HTTP requests which are running behind the scenes.

* If we take a 



