
### Creating Objects

* Create a deployment named `api` with 5 pods, based on an `nginx` image:

* **Imperative** way, directly against the API:
`kubectl -n playground create deployment api --image=nginx`{{copy}}, scale the deployment in the `playground` namespace: `kubectl -n playground scale deployment api --replicas=5`{{exec}}, 

* **Declarative** way, get the  `api` deployment object as a manifest `web_app.yaml`, `kubectl -n playground get deploy api -o yaml > api.yaml`{{exec}}. 

* Check the drift: `kubectl diff -f api.yaml`{{copy}} 

* Scale up the deployment to 3 replicas: `kubectl -n playground scale deployment api --replicas=3`{{copy}}. Check the drift again. Can yoy apply the manifest?

* Delete the deployment: `kubectl -n playground delete deploy api`{{exec}}. And created declaratively: `kubectl apply -f api.yaml`{{exec}}. What happens ?

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
last-applied-configuration annotation is used by <code>kubectl apply</code> by default (client side apply) to store the previous configuration of the object, to avoid conflicts and to calculate the diff between the last applied configuration and the current state of the object. If you want to use server side apply, you can use <code>kubectl apply --server-side</code> and then you don't need to worry about the last-applied-configuration annotation.

<br>
To delete the deployment: <code>kubectl -n playground delete deploy api</code> and then create it declaratively: <code>kubectl apply -f api.yaml --server-side</code> check last-applied-configuration annotation: <code>kubectl -n playground get deploy api -o yaml | grep -i "last-applied-configuration" -A 10</code>
</details>