
### Deploy nginx

* Create a `nginx-deployment` deployment based on `nginx:1.14.2` image

* Inspect the container's name and image: `-ojsonpath="{.spec.containers[*].name}{'\n'}"`{{copy}}

* Scale the deployment to 3 pods
 
* Update the deployment to use `nginx:1.27.4-alpine-slim`{{copy}} image

* Rollback to the previous revision

<details>
<summary>Hint</summary>
 Create deployment <code>kubectl create deployment nginx-deployment --image=nginx:1.14.2</code> 
 <br><br>

 Get Pods IP: <code>kubectl get $(kubectl  get po -l app=nginx-deployment -oname)  -ojsonpath="{.status.podIP}"</code>
 <br><br>

 Get container image: <code>kubectl get $(kubectl  get po -l app=nginx-deployment -oname) -ojsonpath="{.spec.containers[*].image}"</code>
 <br><br>

 Scale deployment <code>kubectl scale deployment nginx-deployment --replicas 3</code>
 <br><br>

Trigger a rolling update of the deployemnt<code>kubectl set image deployments nginx-deployment nginx=nginx:1.27.4-alpine-slim</code> by updating the container image.
 <br><br>

 Check revisions <code>kubectl rollout history deployment nginx-deployment</code>
 Rollback to the previous revision <code>kubectl rollout undo deployment nginx-deployment --to-revision=1</code>
</details>