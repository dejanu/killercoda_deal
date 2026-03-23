
### Creating Objects

* Create a deployment named `api` with 5 pods, based on an `nginx` image:

* **Imperative** way, directly against the API:
`kubectl -n playground create deployment api --image=nginx`{{copy}}, scale the deployment in the `playground` namespace: `kubectl -n playground scale deployment api --replicas=5`{{exec}}, 

* **Declarative** way, get the  `api` deployment object as a manifest `web_app.yaml`, `kubectl -n playground get deploy api -o yaml > api.yaml`{{exec}}. 

* Check the drift: `kubectl diff -f api.yaml`{{copy}} 

* Scale up the deployment to 2 replicas: `kubectl -n playground scale deployment api --replicas=3`{{copy}}. Check the drift again.

* Check the status of pods and deployments: `kubectl -n playground get po,deploy`{{exec}}, furthermore if any of the pods are deleted, they will be automatically **recreated**. ⚠️ Delete ALL resources of a certain type, i.e. all pods: `kubectl  -n playground delete --all pod`{{copy}}

* Scale up one of the deployments: `kubectl -n playground scale deployment nginx-reverse-proxy --replicas 6`{{copy}}. Check the pods `kubectl -n playground get po`{{exec}} . Update the strategy type to `Recreate`, then change the image `kubectl -n playground set image deploy nginx-reverse-proxy nginx=nginx:1.27.1-alpine`{{exec}}. What are the differences? `kubectl -n playground get po`{{exec}}

* Delete deployments: `kubectl -n playground delete deploy nginx-reverse-proxy`{{exec}} and `kubectl delete -f web_app.yaml`{{exec}} to delete `declarative-nginx-reverse-proxy`.