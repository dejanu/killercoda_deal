
### 101

* Running `kubectl get nodes -owide`{{exec}} will give us a general idea about the cluster size, and the number of workers and master nodes.

* Kubectl architecture is fully API-driven, the API Server which is the core of Kubernetes’s control-plane, if we want to take a look at it 
we can increase the verbosity level of `kubectl`
`kubectl get no -v=8`{{exec}} in order to take a look at the HTTP requests which are running behind the scenes.



