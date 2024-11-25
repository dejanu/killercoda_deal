
### Create network policie

Create a networkpolici (e.g. `test-network.yaml`) that uses pod selectors to ALLOW INCOMING connections TO a `web-server` application tier FROM a cache tier.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: test-network-policy
  namespace: test
spec:
  podSelector:
    matchLabels:
      app-tier: web
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app-tier: cache
    ports:
    - protocol: TCP # supported values: "TCP", "UDP", "SCTP"
      port: 80
```

`kubectl apply -f test-network.yaml`, spin up once more the pod `test` in the `default` namespace and retry the `wget ...` cmd. What can you observer?

Now in order to reach `web-server` from `test` pod, we can only spin-up in the `test` namespace: `kubectl run busybox -n test -l app-tier=cache --image=busybox --env="web_ip=$web_ip" --rm -it /bin/sh`{{copy}}