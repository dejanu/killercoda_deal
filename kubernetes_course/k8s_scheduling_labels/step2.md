
### Explore node labels

Check node labels: `kubectl  get no --show-labels`{{copy}}

Same as previous, we can label nodes as well, label the **first** worker nodes with `target:yes`.Verify if node was labeled: `kubectl get no -l target=yes`

Create a simple pod `kubectl run nginx --image=nginx:latest -oyaml --dry-run=client > podngnix.pod`{{copy}} and using [node selector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) schedule the pod on the previously labeled node.Verify where pod is running:`kubectl get po -owide` 

```yaml
spec:
  nodeSelector:
    target: "yes"
  containers:
    ...
```

**Delete the pod**, and remove label `target:yes` from node and add the label to the **control plane** node 🫨...`kubectl label node controlplane target=yes` and recreate the pod. What happens? 
```bash
1 node(s) didn't match Pod's node affinity/selector, 1 node(s) had untolerated taint {node-role.kubernetes.io/control-plane:}
```

Try to look at **Taints**: `kubectl describe no controlplane`...we need some tolerations for our pod.

```yaml
  nodeSelector:
    target: "yes"
  containers:
  - image: nginx:latest
  ....
  # add section
  tolerations:
  - key: "node-role.kubernetes.io/control-plane"
    operator: "Exists"
    effect: "NoSchedule"
```

<details>
<summary>Hint</summary>
Label node: <code>kubectl label node node01 target=yes</code>
<br>
Remove label from node: <code>kubectl label node node01 target-</code>
<br>
</details>