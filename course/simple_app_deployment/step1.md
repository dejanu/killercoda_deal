
### Create app

* In `/root/demo` dir we have our app `main.go` a simple web app, you can start it `go run main.go &`{{exec}} and test it
`curl localhost:3333/hello`{{exec}}.

* The service should respond with
```bash
got / request
Hello world!
```
* Stop the app `kill %1`{{exec}}
--

* Build the image `docker build -t demo:v1.0 .` using the current dir `demo` as build context

* Create deployment for our app `kubectl create deployment nginx --image=demo:v1.0 --dry-run=client -oyaml > deploy.yaml` and deploy the app `kubectl apply -f deploy.yaml`

