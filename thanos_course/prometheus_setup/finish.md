
<br>

### WELL DONE !


* Deployment reference [here](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

* Summary:

    Deployment + `emptyDir` has no persistence.
    Deployment + PVC persists but only works for a **single replica**.
    StatefulSet persists and supports HA, because each replica has its own volume.