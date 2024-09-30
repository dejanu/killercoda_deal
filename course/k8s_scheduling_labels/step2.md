
### Explore node labels



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