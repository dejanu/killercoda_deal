
### Sidecar container


* Spin-up another nginx pod, by running `kubectl  apply -f sidecar_pod.yaml`{{copy}} 

* Sidecar container are just init containers with [restartPolicy: Always](https://kubernetes.io/blog/2023/08/25/native-sidecar-containers/#what-are-sidecar-containers-in-1-28)  `kubectl get po  nginx-with-logging-sidecar -ojsonpath="{.spec.initContainers[*].name} AND {.spec.containers[*].name} "`{{exec}}


* Inspect the pod `kubectl describe po nginx-with-logging-sidecar`{{copy}}. 

* `log-shipper` is a sidecar container (in a real setup, you'd replace the tail-like app with something like FluentBit or Filebeat that actually ships logs somewhere)

* `nginx` main app container does not know/care that the sidecar exists, Pod termination continues to only depend on the main containers. 


* Kill the sidecar container: `kubectl get po`

```bash
# get restart count for nginx
kubectl get pod nginx-with-logging-sidecar -o jsonpath='{.status.containerStatuses[?(@.name=="nginx")].restartCount}{"\n"}'

# get restart count for sidecar
kubectl get pod nginx-with-logging-sidecar -o jsonpath='{.status.initContainerStatuses[?(@.name=="log-shipper")].restartCount}{"\n"}'

# get sidecar container id: crictl ps -a
kubectl get pod nginx-with-logging-sidecar -o jsonpath='{.status.initContainerStatuses[?(@.name=="log-shipper")].containerID}{"\n"}'

# kill sidecar container
crictl stop <CONTAINER_ID>
```
