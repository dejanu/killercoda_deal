
### Deploy nginx

* Create deployment called `nginx-deployment` based on `nginx:1.14.2` image

* Take a look at pods created by the deployment and their labels.

* Inspect the container's name, image: `-ojsonpath="{.spec.containers[*].name}{'\n'}"`{{copy}}

* Scale the deployment to 3 pods, and check the Pod IPs.
 
* Update the deployment to use `nginx:1.27.4-alpine-slim`{{copy}} image

* Rollback to the previous revision

<details>
<summary>Hint</summary>
 Create deployment <code>kubectl create deployment nginx-deployment --image=nginx:1.14.2</code> 
 <br><br>

 Show pods and their labels <code>kubectl get pods --show-labels</code>. The <code>app</code> label was atomatically generated and set to the deployment's name.
 <br><br>

 Get container image: <code>kubectl get po -ojsonpath="{.spec.containers[*].image}"</code>
 <br>
 Get containers images: <code>kubectl get po  -ojsonpath="{.items[*].spec.containers[*].name}"</code> 
 <br><br>
 
 Get Pods IP: <code>kubectl get pods -l app=nginx-deployment -o jsonpath='{.items[*].status.podIP}'</code>
 <br><br>

 Scale deployment <code>kubectl scale deployment nginx-deployment --replicas 3</code>
 <br><br>

Trigger a rolling update of the deployment<code>kubectl set image deployments nginx-deployment nginx=nginx:1.27.4-alpine-slim</code> by updating the container image.
 <br><br>

 Check revisions <code>kubectl rollout history deployment nginx-deployment</code>.
 Rollback to the previous revision <code>kubectl rollout undo deployment nginx-deployment --to-revision=1</code>
</details>