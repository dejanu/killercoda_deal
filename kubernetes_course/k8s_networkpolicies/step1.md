
### Explore pod labels and network policies

Check labels for pods in all namespaces `kubectl get po --show-labels -A`{{copy}}. Pay attention at `app-tier` label.

Get the IP for `web-server` pod running in `test` namespace: `kubectl get pod -n test -o jsonpath='{.items[0].status.podIP}'`{{copy}}

Spin-up a pod named `busybox` in the `default` namespace (with value `cache` for label `app-tier`) and try to reach the `web-server` pod using `wget` from `busybox` within a interactive session, i.e `wget WEB_SERVER_IP`. What can you see?

```bash
...
saving to 'index.html'
...
```

<details>
<summary>Hint</summary>
Get IP : <code>web_ip=$(kubectl -n test get po web-server -ojsonpath="{.status.podIP}")</code>
<br>
Spin up pod: <code>kubectl run busybox -l app-tier=cache --image=busybox --env="web_ip=$web_ip" --rm -it /bin/sh</code> and run <code>wget $web_ip</code>
<br>
</details>

<hr>

