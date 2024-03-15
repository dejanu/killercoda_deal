
### Objects

* To obtain a comprehensive list of available objects, you can simply execute the command: `kubectl api-resources -oname`{{exec}}

* Check the pods running in `playground` namespace: `kubectl -n playground get po`

* To get the declarative reporesentation of the objects, we can simply: `kubectl -n playground get po basic -o yaml`{{exec}}

### Creating objects

* Create a deployment named `nginx-reverse-proxy` with 2 replicas, based on an  `nginx` image:

* Imperative way:
`kubectl -n playground create deployment nginx-reverse-proxy --image=nginx:stable-alpine-perl --replicas=2`{{exec}}, check the pod in the `playground` namespace: `kubectl -n playground get po`

* Declarative way:

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
        image: nginx:latest
        ports:
        - containerPort: 80
EOF
```

* Now simply: `kubectl apply -f web_app.yaml` to create `declarative-nginx-reverse-proxy` deployment.

* Check pods and deployments: `kubectl -n playground get po,deploy`{{exec}}

* Delete deployments: `kubectl delete deploy nginx-reverse-proxy` and `kubectl delete -f web_app.yaml` to delete `declarative-nginx-reverse-proxy`