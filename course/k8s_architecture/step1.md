
### Kubernetes components

* Running `kubectl get nodes -owide`{{exec}} will give us a general idea about the cluster size (the number of workers and master nodes).

* Kubernetes architecture is fully API-driven, the API Server is the core of Kubernetes’s control-plane, to inspect it we can enhance the verbosity level of `kubectl`, in order to take a look at the HTTP requests which are running behind the scenes:
`kubectl get no -v=8`{{exec}}

* If we take a look at the `kube-system` namespace (which is the namespace for objects created by the Kubernetes system) `kubectl -n kube-system get po`{{exec}} we can see the: **apiserver**, **controller-manager**, **scheduler components**.

* A quick way the to check the components status is by running `kubectl get componentstatuses`{{exec}} which is a call to
`kubectl get --raw /api/v1/componentstatuses | jq .`{{exec}}.



