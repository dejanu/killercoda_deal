
### Deploy nginx

* Create a simple deployment based on `nginx:1.14.2` image

* Inspect the Pod and get the IP

* Scale the deployment to 3 pods
 
* Update the deployment to use `nginx:1.27.4-alpine-slim` image

<details>
<summary>Hint</summary>
 Create deployment <code>kubectl  create deployment nginx --image=nginx:1.14.2</code> 
 Get Pods IP <code>kubectl  get po nginx-...  -ojsonpath="{.status.podIP}"</code> 
 Scale deployment <code>kubectl  scale deployment  nginx --replicas 3</code>
</details>