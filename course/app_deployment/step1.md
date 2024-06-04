
### Package the app

* In `cd /root/demo`{{exec}}  dir we have our app `main.go` a simple web app, you can start it `go run main.go &`{{exec}} and test it
`curl localhost:3333/hello`{{exec}}.

* The service should respond with
```bash
got / request
Hello world!
```
* Stop the app `kill %1`{{exec}}

<hr>

* Create go module: `go mod init example.com/demo`{{exec}} 

* Build the image `docker build -t dejanualex/demo:v1.0 .`{{exec}} using `demo` directory as build context.


### Deploy the app

* Create **deployment** for our app `kubectl create deployment demo-app --image=dejanualex/demo:v1.0 --dry-run=client -oyaml > deploy.yaml`{{exec}}.
Inspect the deployment manifest file `cat deploy.yaml`{{exec}} and deploy the app `kubectl apply -f deploy.yaml`{{exec}}

* Create **service** to expose `demo-app` deployment `kubectl expose deploy demo-app --name=demo-svc --port=3333 --target-port=3333`{{exec}}, verify that the services was created `kubectl get svc`{{exec}}

* Spin up pod with curl `kubectl  run curlopenssl -i --tty --image=dejanualex/curlopenssl:1.0  -- sh`{{exec}} (If you don't see a command prompt, try pressing enter.) and run `curl demo-svc.default.svc.cluster.local:3333/hello`{{exec}} to test our app. You should be able to have:

```bash
/ # curl demo-svc.default.svc.cluster.local:3333/hello
Hello world!
```