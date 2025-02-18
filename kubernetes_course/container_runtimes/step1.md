
### Container runtimes

* A container runtime is a software component responsible for executing and managing containerized applications on a host operating system. e.g. runC, containerd, rkt, cri-o.

![Scan results](./assets/container_runtimes.png)


* Docker Engine utilizes [runc](https://github.com/opencontainers/runc) as a lightweight, portable container runtime under the hood, and [containerd](https://containerd.io/) to provide a runtime environment for containers. Subsequently donated [runc](https://github.com/opencontainers/runc) to [OCI](https://opencontainers.org/about/overview/) as a reference implementation, and [containerd](https://containerd.io/) to [CNCF](https://www.cncf.io/projects/containerd/).

* **runc** includes all of the plumbing code used by **Docker** to interact with system features related to containers. 

* To see which container runtimes Docker uses, run `docker system info --format "{{ .Runtimes }}"`{{exec}}. To find out the default runtime, run `docker system info --format "{{ .DefaultRuntime }}"`{{exec}}.


* Although [runc](https://github.com/opencontainers/runc) is primarily utilized by higher-level container software such as [containerd](https://containerd.io/), it is still possible to create and launch a container directly using `runc`. A setup (root filesystem + spec) has been created in `mycontainer` directory for a [busybox](https://hub.docker.com/_/busybox) based container.

* **Running containers**: `cd /mycontainer`{{exec}} and create `busybox` container directly using `runc run busybox -d`{{exec}}, check the status of the container using `runc list`{{exec}}. The container should run for 5 seconds and stop afterwards (since this is the desired behaviour described in the specs `grep -A2 "args" config.json `{{exec}}).

* Now we can delete the container `runc delete busybox`{{exec}}