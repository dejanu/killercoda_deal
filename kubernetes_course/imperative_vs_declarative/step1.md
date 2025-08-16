
### Objects

* To obtain a comprehensive list of available objects, simply run the command: `kubectl api-resources`{{exec}}

* To view the deployments and pods running in the `playground` namespace using the objects shortname : `kubectl -n playground get po,deploy`{{exec}}

* Within the namespace there is a pod named `basic` which is NOT bound to a ReplicaSet or Deployment, commonly referred to as a "naked pod".

* To get the declarative reporesentation of the pod just execute: `kubectl -n playground get po basic -o yaml`{{exec}}

* Moreover if this pod is deleted `kubectl -n playground delete po basic`{{exec}}, it won't be automatically recreated since it's a "naked pod". Naked pods will not be rescheduled in the event of node failure: `kubectl -n playground get po,deploy`{{exec}}

### Creating objects

* Create a deployment named `nginx-reverse-proxy` with 2 replicas, based on an `nginx` image:

* **Imperative** way, directly against the API:
`kubectl -n playground create deployment nginx-reverse-proxy --image=nginx:stable-alpine-perl --replicas=2`{{exec}}, check the pod in the `playground` namespace: `kubectl -n playground get po`{{exec}}, you should see the running pods:

```bash
NAME                                   READY   STATUS    RESTARTS   AGE
nginx-reverse-proxy-55d9dfc748-99gq7   1/1     Running   0          6s
nginx-reverse-proxy-55d9dfc748-h4694   1/1     Running   0          6s
```

* **Declarative** way, by defining the object as a manifest `web_app.yaml`, and applying the configuration to the cluster:

```bash
cat<<EOF>>web_app.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: declarative-nginx-reverse-proxy
  namespace: playground
spec:
  replicas: 2
  selector:
    matchLabels:
      app: declarative-nginx-reverse-proxy
  template:
    metadata:
      labels:
        app: declarative-nginx-reverse-proxy
    spec:
      containers:
      - name: nginx
        image: nginx:stable-alpine-perl
        ports:
        - containerPort: 80
EOF
```{{exec}}

* Now simply: `kubectl apply -f web_app.yaml`{{exec}} to create `declarative-nginx-reverse-proxy` deployment.

* Check the status of pods and deployments: `kubectl -n playground get po,deploy`{{exec}}, furthermore if any of the pods are deleted, they will be automatically **recreated**. ⚠️ Delete ALL resources of a certain type, i.e. all pods: `kubectl  -n playground delete --all pod`

* Scale down one of the deployments: `kubectl -n playground scale deployment nginx-reverse-proxy --replicas 1`{{exec}}

* Delete deployments: `kubectl -n playground delete deploy nginx-reverse-proxy`{{exec}} and `kubectl delete -f web_app.yaml`{{exec}} to delete `declarative-nginx-reverse-proxy`.