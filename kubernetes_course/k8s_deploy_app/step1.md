
### Deploy nginx

* Create a `nginx-deployment` deployment based on `nginx:1.14.2` image

* Inspect the Pod's IP and container's image

* Scale the deployment to 3 pods
 
* Update the deployment to use `nginx:1.27.4-alpine-slim` image

* Rollback to the previous revision

<details>
<summary>Hint</summary>
 Create deployment <code>kubectl create deployment nginx-deployment --image=nginx:1.14.2</code> 
 <br>
 Get Pods IP <code>kubectl get po nginx-...  -ojsonpath="{.status.podIP}"</code>
 <br>
 Get container image <code>kubectl get po nginx-... -ojsonpath="{.spec.containers[*].image}"</code>
 <br>
 Scale deployment <code>kubectl scale deployment nginx-deployment --replicas 3</code>
 <br>
 Update deployment image <code>kubectl set image deployments nginx-deployment nginx=nginx:1.27.4-alpine-slim</code>
 <br>
 Check revisions <code>kubectl rollout history deployment nginx-deployment</code>
 Rollback to the previous revision <code>kubectl rollout undo deployment nginx-deployment --to-revision=1</code>
</details>