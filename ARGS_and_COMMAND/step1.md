
### Default start

* Start a pod named `cowsay` using the default behaviour of the container:
`kubectl run cowsay --image=dejanualex/dockersay:1.1 --restart=Never`{{exec}}

* Since Kubernetes it will capture anything written to STDOUT as a log message we can check the logs of the pod:
 `kubectl logs cowsay`{{exec}}

* Delete pod `cowsay`:
`kubectl delete po cowsay`{{exec}}

### Start using ARGS

* Start a pod named `cowsay` using  `my args` string as `ARGS`:
`kubectl run cowsay --image=dejanualex/dockersay:1.1 --restart=Never -- my args`{{exec}}

* Check the logs of the pod, **What differences do you observe?**:
`kubectl logs cowsay`{{exec}}

* We've overridden the default arguments of our app `cowsay` by passing our custom arguments, furthermore we can inspect the pod and see what are the args: 
`kubectl get po cowsay -ojsonpath="{.spec.containers[0].args}"`{{exec}}

* Delete pod `cowsay`:
`kubectl delete po cowsay`{{exec}}

### Start using COMMAND

* Start a pod named `cowsay` using  `cowsay` string as `COMMAND`:
`kubectl run cowsay --image=dejanualex/dockersay:1.1 --restart=Never --command -- cowsay`{{exec}}
 
⚠️ The command that we pass to the container must be an executable located in the container's `$PATH`, i.e. `kubectl run cowsay --image=dejanualex/dockersay:1.1 --restart=Never --command -- my_command` will translate into the following error:

```bash
 Error: failed to start container "cowsay": Error response from daemon: failed to create task for container: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: exec: "my_command": executable file not found in $PATH: unknown
```
* Check the logs of the pod, **What differences do you observe?**:
`kubectl logs cowsay`{{exec}} 

* If we inspect the `CMD` for our pod `kubectl get po cowsay -ojsonpath="{.spec.containers[0].command}"` we can see that we've overriden the default behaviour of our app, more exactly the container's ENTRYPOINT, if by default the container starts `cowsay Hello World!` now we've managed to start only `cowsay` app without any arguments.



