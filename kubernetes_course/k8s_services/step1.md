## Services 101

* Spin-up pod: `docker run -p 8888:8888 dejanualex/pythonhello:1.1 `{{exec}}, and check endpoint: `curl localhost:8888`{{exec}}

* Deploy app: `kubectl create deployment pythonapp --image=dejanualex/pythonhello:1.1`{{exec}}

* Spin-up a "naked" pod in `test` namespace and try to reach app endpoint whithout any service: `kubectl -n test run curlopenssl --rm -i --tty --image=dejanualex/curlopenssl:1.0  -- sh`{{exec}}

* Next create a service called `pythonapp-svc`{{copy}}. And try to reach the endpoint using the service name `curl -s pythonapp-svc.default.svc.cluster.local:8081`

* Delete the ClusterIP service `kubectl delete svc pythonapp-svc`{{exec}} and **create** a new one to be of type `NodePort`. Can you reach the endpoint using the node IP and NodePort? `NodePort` Exposes the Service on each Node's IP at a static port (the NodePort). To make the node port available, Kubernetes sets up a cluster IP address.
Now reach the endpoint in the new way.

<details>
<summary>Hints</summary>
Create namespace: <code>kubectl create ns test</code>. You can reach the app using the podIP<code>kubectl get po -o wide</code> and then <code>kubectl exec po/curlopenssl -- curl &lt;podIP&gt;:8888</code>
<br>
<br>
A Service can map any incoming port to a targetPort. By default and for convenience, the targetPort is set to the same value as the port field.
The app is running on port 8888, therefore create the service accordingly: <code>kubectl expose deployment pythonapp --name=pythonapp-svc --port=8081 --target-port=8888</code>.
<br>
<br>
Create the service of type NodePort: <code>kubectl expose deployment pythonapp --name=pythonapp-svc --port=8081 --target-port=8888 --type=NodePort</code>. Or you can also
Update service to NodePort <code>kubectl patch svc pythonapp-svc -p '{"spec": {"type": "NodePort"}}'</code> 
<br>
<br>
To access it <code>kubectl get no -owide</code>, <code>kubectl get svc pythonapp-svc -o wide</code> and then <code>curl &lt;nodeIP&gt;:&lt;NodePort&gt;</code>.
NodePort adds external accessibility but doesn’t break internal DNS/ClusterIP access it opens a specific port on all nodes (30000-32767) and forwards traffic to the service.
<br>
</details>
