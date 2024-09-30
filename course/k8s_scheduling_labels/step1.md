
### Explore pod labels

In order to view labels for pods in **default** namespace: `kubectl get po --show-labels`{{copy}}

List all pods with label `env` and extract to a file all pods which have `env` label **prod**.

List of all pod's names running in the **default** namespace which have their `env` label either **prod**, or **preprod**. The returned list should contain only the pod names and nothing else.

List of all pod's names running in the **default** namespace which have their `env` label **different** from `dev` value.
The returned list should contain only the pod names and nothing else.
`kubectl get pods -l 'env notin (dev)'`{{exec}}

<details>
<summary>Hint</summary>
List all pods with <code>env</code> label: <code>kubectl get po -L env</code>
<br>
Select all pods with <code>prod</code> label value: <code>kubectl get pods -l env=prod</code> (equality based)
<br>
Select pods with label values <code>prod,nonprod</code>: <code>kubectl get po -l "env in (prod,preprod)" -oname</code> (set based)
<br>
Select pods with label values diffrent from <code>prod,nonprod</code>: and fix <code>kubectl get pods -l 'env notin (dev)'</code>
</details>

* Cleanup: `kubectl delete po app0 app1 app2 app3`{{exec}}