
### Package the app

* In `/root/demo` dir we have our app `main.go` a simple web app, you can start it `go run main.go &`{{exec}} and test it
`curl localhost:3333/hello`{{exec}}.

* The service should respond with
```bash
got / request
Hello world!
```
* Stop the app `kill %1`{{exec}}

<hr>

* Create go module `cd demo`{{exec}} and run `go mod init example.com/demo`{{exec}} 

* Build the image `docker build -t demo:v1.0 .` using `demo` directory as build context

* Create deployment for our app `kubectl create deployment demo-app --image=demo:v1.0 --dry-run=client -oyaml > deploy.yaml` and deploy the app `kubectl apply -f deploy.yaml`

* Create **service** to expose `demo-app` deployment `kubectl  expose deploy demo-app --name=demo-svc --port=3333 --target-port=3333`{{copy}}


`curl demo-svc.default.svc.cluster.local:3333`