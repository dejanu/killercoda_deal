
### Using Harbor as a proxy-cache

* When configured as a proxy cache, Harbor sits between your users or systems and external public registries. Instead of each system accessing the public registry directly, Harbor acts as a smart intermediary.

* Download Harbor chart

```bash
helm repo add harbor https://helm.goharbor.io
helm fetch harbor/harbor --untar
```
* Install harbor

```bash
# install a release in the default namespace
helm install harbor-release ./harbor \
  --set expose.type=clusterIP \
  --set expose.tls.auto.commonName=localhost \
  --set externalURL=https://localhost:8443

# verify installation
helm list  

# keep port-forward running; bind all interfaces
kubectl port-forward --address 0.0.0.0 services/harbor 8080:443
```

* Get the DNS for the LB and then update current release

```bash
# get the DNS for the LB and then update current release i.e. 98bf0b64edb5-10-244-10-178-8088.spca.r.killercoda.com
helm upgrade harbor-release ./harbor  --reuse-values --set expose.tls.enabled=false  --set externalURL=https://<your-killercoda-host>

#  port forward on a different port
kubectl port-forward --address 0.0.0.0 services/harbor 8080:80
```