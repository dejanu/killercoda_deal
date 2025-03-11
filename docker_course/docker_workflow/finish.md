
<br>

### WELL DONE !

* Dockerfile reference [here](https://docs.docker.com/reference/dockerfile/)
* Docker build documentation [here](https://docs.docker.com/reference/cli/docker/image/build/)
* For Kubernetes restart policy is pretty [important](https://stackoverflow.com/a/77107007/7013263)

```bash
# default restart policy is always -> CrashLoopBackOff
kubectl run test --image=dejanualex/dockersay:2.0
# behaves like a job
kubectl run test --restart=Never --image=dejanualex/dockersay:2.0
```