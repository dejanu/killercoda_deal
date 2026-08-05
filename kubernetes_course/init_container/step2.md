
### Sidecar container


* Spin-up another nginx pod, by running `kubectl  apply -f sidecar_pod.yaml`{{copy}} 

* Sidecar container are just init containers with [restartPolicy: Always](https://kubernetes.io/blog/2023/08/25/native-sidecar-containers/#what-are-sidecar-containers-in-1-28)  `kubectl get po  nginx-with-logging-sidecar -ojsonpath="{.spec.initContainers[*].name} AND {.spec.containers[*].name} "`{{exec}}


* Inspect the pod `kubectl describe nginx-with-logging-sidecar`{{copy}}. 

* `log-shipper` is a sidecar container (in a real setup, you'd replace the `tail` command with something like FlunetBit or Filebeat that actually ships logs somewhere)

* `nginx` main app container does not know/care that the sidecar exists, Pod termination continues to only depend on the main containers.