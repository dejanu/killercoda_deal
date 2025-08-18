
### Objects

* A K8S objects is a "record if intent", almost every object has two nested fields: **object**`.spec` (desired state) and **object**`.status` (most recently observed status of the object). (don't forget to `kubect explain ...`😉)

* To obtain a comprehensive list of available objects, simply run the command: `kubectl api-resources`{{exec}}

* To view the deployments and pods running in the `playground` namespace using the objects shortname : `kubectl -n playground get po,deploy`{{exec}}

* Within the namespace there is a pod named `basic` which is NOT bound to a ReplicaSet or Deployment, commonly referred to as a "naked pod".

* To get the declarative reporesentation of the pod just execute: `kubectl -n playground get po basic -o yaml`{{exec}}

* Moreover if this pod is deleted `kubectl -n playground delete po basic`{{exec}}, it won't be automatically recreated since it's a "naked pod". Naked pods will not be rescheduled in the event of node failure: `kubectl -n playground get po,deploy`{{exec}}

