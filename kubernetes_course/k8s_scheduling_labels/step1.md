
### Explore pod labels

In order to view labels for pods in **default** namespace: `kubectl get po --show-labels`{{copy}}. For starters check all pods which have `env` label: `kubectl get po -L env`{{copy}}

List all pods which have `env` label **prod**.

List of all pod's names running in the **default** namespace which have `env` label either **prod** or **preprod**. The returned list should contain only the pod names and nothing else.

Add new labels `env=dev`{{copy}} and `foo=bar` to pod `app4` running in the **default** namespace. 

List of all pod's names running in the **default** namespace which have their `env` label **different** from `dev` value. The returned list should contain only the pod names and nothing else.

Label all pods which have `env=preprod` label with a new label `tag=stagging`

<details>
<summary>Hint</summary>
Select all pods with <code>prod</code> label value: <code>kubectl get pods -l env=prod</code> (equality based)
<br>
Select pods with label values <code>prod,preprod</code>: <code>kubectl get po -l "env in (prod,preprod)" -oname</code> (set based)
<br>
Add new label <code>kubectl label po app4 env=dev</code> and overwrite label <code>kubectl label po app4 foo=bar --overwrite</code> 
<br>
Select pods with label values diffrent from <code>prod,preprod</code>: <code>kubectl get pods -l 'env notin (prod,preprod)'</code>
<br>
Label all pods which have <code>env=preprod</code> with <code>tag=stagging</code>: <code>kubectl label pod --selector env=preprod tag=staging</code>
</details>

<hr>

* Cleanup: `kubectl delete po app0 app1 app2 app3 app4`{{exec}}