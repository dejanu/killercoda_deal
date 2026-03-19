## Debug the current pod

* Check pod status, inspect events:

* startupProbe is holding bliveness/readiness until startup succeeds

```bash
kubectl get pods
kubectl describe pod probe-lab
kubectl logs probe-lab --previous
```

<details>
<summary>Hints</summary>

```
     startupProbe:
        httpGet:
          path: /
          port: 8080
        initialDelaySeconds: 1
        periodSeconds: 3
        failureThreshold: 6
```
<br>

</details>
