
### Creating Objects

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

* Check the status of pods and deployments: `kubectl -n playground get po,deploy`{{exec}}, furthermore if any of the pods are deleted, they will be automatically **recreated**. ⚠️ Delete ALL resources of a certain type, i.e. all pods: `kubectl  -n playground delete --all pod`{{copy}}

* Scale up one of the deployments: `kubectl -n playground scale deployment nginx-reverse-proxy --replicas 6`{{copy}}. Check the pods `kubectl -n playground get po`{{exec}} . Update the strategy type to `Recreate`, then change the image `kubectl -n playground set image deploy nginx-reverse-proxy nginx=nginx:1.27.1-alpine`{{exec}}. What are the differences? `kubectl -n playground get po`{{exec}}

* Delete deployments: `kubectl -n playground delete deploy nginx-reverse-proxy`{{exec}} and `kubectl delete -f web_app.yaml`{{exec}} to delete `declarative-nginx-reverse-proxy`.