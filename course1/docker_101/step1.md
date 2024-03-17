
### Container runtimes

* A container runtime is a software component responsible for executing and managing containerized applocations on a host operating system. e.g.: runC, containerd, rkt, cri-o, etc.

![Scan results](./assets/container_runtimes.png)

* As a matter of fact, Kubernetes doesn’t know how to run containers it relies on the container runtime for running and managing containers on a host.