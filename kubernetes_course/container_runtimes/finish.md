
<br>

### WELL DONE !

* Kubernetes documentation for container runtimes [here](https://kubernetes.io/docs/setup/production-environment/container-runtimes/).

* CNCF container runtime definition [here](https://landscape.cncf.io/guide#runtime--container-runtime).

* [Runc](https://github.com/opencontainers/runc) is an implementation of the standard. At the time of writing, it is a repackaging of [libcontainer](https://github.com/docker/libcontainer).

* [Podman](https://podman.io/docs/installation) vs Docker:
While Docker relies on a client-server model, Podman employs a daemonless architecture, more details [here](https://betterstack.com/community/guides/scaling-docker/podman-vs-docker/)

💡 Interesting fact, Kubernetes "doesn’t know" how to run containers it relies on the container runtime for running and managing containers on a host.