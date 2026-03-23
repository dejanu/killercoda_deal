
### Creating Objects

* Create a deployment named `api` with 5 pods, based on an `nginx` image:

* **Imperative** way, directly against the API:
`kubectl -n playground create deployment api --image=nginx`{{copy}}, scale the deployment in the `playground` namespace: `kubectl -n playground scale deployment api --replicas=5`{{exec}}, 

* **Declarative** way, get the  `api` deployment object as a manifest `web_app.yaml`, `kubectl -n playground get deploy api -o yaml > api.yaml`{{exec}}. 

* Check the drift: `kubectl diff -f api.yaml`{{copy}} 

* Scale up the deployment to 3 replicas: `kubectl -n playground scale deployment api --replicas=3`{{copy}}. Check the drift again. 

* Delete the deployment: `kubectl -n playground delete deploy api`{{exec}}. And created declratively: `kubectl apply -f api.yaml`{{exec}}.

<details>
<summary>⚠️ Solution</summary>

Clean up the manifest of the deployment, because you're trying a client side apply
```yaml
metadata:
  resourceVersion:
  uid:
  creationTimestamp:
  generation:

status:
```
<br>
last-applied-configuration annotation is used by `kubectl apply` by default (client side apply) to store the previous configuration of the object.
</details>