
### Container runtimes

* A container runtime is a software component responsible for executing and managing containerized applocations on a host operating system. e.g. runC, containerd, rkt, cri-o.

![Scan results](./assets/container_runtimes.png)

* Interesting fact, Kubernetes doesn’t know how to run containers it relies on the container runtime for running and managing containers on a host.

* Docker utilizes [runC](https://github.com/opencontainers/runc) as a lightweight, portable container runtime under the hood, and [containerd](https://containerd.io/) to provides a runtime environment for Docker containers.
Subsequently donated runC to [OCI](https://opencontainers.org/about/overview/) as a reference implementation, and containerd to [CNCF](https://www.cncf.io/projects/containerd/).

* **runC** includes all of the plumbing code used by **Docker** to interact with system features related to containers, check Docker's container runtime: `docker system info --format "{{ .DefaultRuntime }}"`{{exec}}

* Although **runC** is primarily utilized by higher-level container software such as **containerd**, it is still possible to create and launch a container directly using `runc`. A setup (root filesystem + spec) has been created in `mycontainer`{{exec}} for a [busybox](https://hub.docker.com/_/busybox) based container.

* Running containers: `cd /mycontainer`{{exec}} and create `busybox` container `runc run busybox -d`{{exec}}, check the status of the container using `runc list`{{exec}}. The container should run for 5 seconds and stop afterwards (since this is the desired behaviour described in the specs `grep -A2 "args" config.json `{{exec}}).

* Now we can delete the container `runc delete busybox`{{exec}}