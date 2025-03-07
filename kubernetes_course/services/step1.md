## Services 101

* Spin-up pod: `docker run -p 8888:8888 dejanualex/pythonhello:1.1 `{{exec}}, and check endpoint: `curl localhost:8888`{{exec}}

* Deploy app: `kubectl create deployment pythonapp --image=dejanualex/pythonhello:1.1`{{exec}}

* Create curl "naked" pod: `kubectl  run curlopenssl -i --tty --image=dejanualex/curlopenssl:1.0  -- sh`{{exec}} 

* Create a deployment `kubectl create deploy alpine-test --image=alpine`{{exec}}, check the pods? What is happening and why?

* Create a service called `pythonapp-svc`{{copy}} (and expose different port than the one that app is using) and test if you can reach the endpoint using the service.

<details>
<summary>Hints</summary>
Create service <code>kubectl expose deployment pythonapp --name=pythonapp-svc --port=8081 --target-port=8888</code>
<br>
Check the endpoint using the service <code>kubectl exec po/curlopenssl -- curl -s pythonapp-svc.default.svc.cluster.local:8081></code>
</details>
