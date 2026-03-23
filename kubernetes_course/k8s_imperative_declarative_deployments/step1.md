
### Objects

* A K8S objects is a "record if intent", almost every object has two nested fields: **object**`.spec` (desired state) and **object**`.status` (most recently observed status of the object), don't forget to `kubectl explain ...`😉

* Most often an object is represented as `.yaml` file aka manifest. There are 4 essential fields that must be present in a manifest:

```yaml
apiVersion: # which version of K8S API you're using to create the object, i.e. core API v1 / apps/v1 or v1
kind: # type of object/resource that you're creating
metadata: # metadata about the object, such as name, namespace, labels, and annotations
spec: # desired state for the object
```

* To obtain a comprehensive list of available objects/kinds/resources, simply run the command: `kubectl api-resources`{{exec}}

* To obtain a view of registered API groups and their versions, use: `kubectl get apiservices`{{copy}} or `kubectl api-versions`{{copy}}

* To view the deployments and pods running in the `playground` namespace using the objects shortname : `kubectl -n playground get po,deploy`{{exec}}

* Within the namespace there is a pod named `basic` which is NOT bound to a ReplicaSet or Deployment, commonly referred to as a "naked pod".

* To get the declarative reporesentation of the pod just execute: `kubectl -n playground get po basic -o yaml`{{exec}}, and save it to disk.

* Moreover if this pod is deleted `kubectl -n playground delete po basic`{{exec}}, it won't be automatically recreated since it's a "naked pod". Naked pods will not be rescheduled in the event of node failure: `kubectl -n playground get po,deploy`{{exec}}


* Check the status of pods and deployments: `kubectl -n playground get po,deploy`{{exec}}, furthermore if any of the pods are deleted, they will be automatically **recreated**. ⚠️ Delete ALL resources of a certain type, i.e. all pods: `kubectl  -n playground delete --all pod`{{copy}}

* Scale up one of the deployments: `kubectl -n playground scale deployment nginx-reverse-proxy --replicas 6`{{copy}}. Check the pods `kubectl -n playground get po`{{exec}} . Update the strategy type to `Recreate`, then change the image `kubectl -n playground set image deploy nginx-reverse-proxy nginx=nginx:1.27.1-alpine`{{exec}}. What are the differences? `kubectl -n playground get po`{{exec}}

* Delete deployments: `kubectl -n playground delete deploy nginx-reverse-proxy`{{exec}} and `kubectl delete -f web_app.yaml`{{exec}} to delete `declarative-nginx-reverse-proxy`.



* You can use apply to reference remote manifests: `kubectl apply -f https://raw.githubusercontent.com/dejanu/k8s_logging/refs/heads/main/nginx_pod.yaml`{{copy}}

* 💡 To explore Kubernetes API space you can run kubectl as a reverse proxy to serve the API: `kubectl proxy -p 8080&` and the use `curl` to explore the API: 
`curl http://localhost:8080/api/` i.e. `curl http://localhost:8080/api/v1/pods`

