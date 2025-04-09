
## Kubernetes Scheduler


In Kubernetes, scheduling refers to making sure that Pods are matched to Nodes so that Kubelet can run them.

**kube-scheduler** is the default scheduler for Kubernetes and runs as part of the control plane.

Scheduler runs a static pod (`/etc/kubernetes/manifests`) on the control plane: `kubectl -n kube-system get po`. Stop the scheduler and create a naked nginx pod: `kubectl run po nginx --image=nginx`.What happens?

Assign pod to nodes aka. bypass the scheduler, by using [nodeName](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodename)

```bash
cat<<EOF>>nginx.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
  nodeName: <INSERT NODENAME>
EOF
```{{exec}}

