
### Create network policy

Create a networkpolicy(e.g. `test-network-policy`) that isolates `web` Pods so only `cache` Pods can talk to them on TCP port 80.

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
```{{copy}}

Check it the networkpolicy has been created `kubectl  get networkpolicies.networking.k8s.io -n test`{{copy}} (Native Kubernetes API networkpolicy object)

Which Pods or sources are allowed to access the web app? i.e. `wget $web_ip --timeout=5`{{copy}}

*  `kubectl run busybox -n test --image=busybox --env="web_ip=$web_ip" --rm -it /bin/sh`{{copy}}

*  `kubectl run busybox -n test -l app-tier=cache --image=busybox --env="web_ip=$web_ip" --rm -it /bin/sh`{{copy}}

*  `kubectl run busybox -l app-tier=cache --image=busybox --env="web_ip=$web_ip" --rm -it /bin/sh`{{copy}}