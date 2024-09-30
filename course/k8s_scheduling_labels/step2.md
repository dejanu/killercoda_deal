
### Explore node labels

Check node labels: `kubectl  get no --show-labels`{{copy}}

Same as previous, we can label nodes as well, label the **first** worker nodes with `target:yes`.

Create a simple pod `kubectl run nginx --image=nginx:latest -oyaml --dry-run=client > ngnix.pod`{{copy}} and using [node selector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) schedule the pod on the previously labeled node.

```yaml
spec:
  nodeSelector:
    target: "yes"
  containers:
    ...
```

Finally remove label `target:yes` from node.

<details>
<summary>Hint</summary>
Label node: <code>kubectl label node node01 target=yes</code>
<br>
Remove label from node: <code>kubectl label node node01 -target</code>
<br>
</details>