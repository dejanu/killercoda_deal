
### Explore labels

* Check all pods running in the `default` namespace:
`kubectl get po --show-labels`{{exec}}

* List all pods with label `env`:
`kubectl get po -L env`{{exec}}

### Select pods based on label

* Get a list of all pod names running in the **default** namespace which have their **env** label either **prod**, or **preprod**.
The returned list should contain only the pod names and nothing else.
`kubectl get po -l "env in (prod,preprod)" -oname`{{copy}}

* Get a list of all pod names running in the **default** namespace which have their **env** label different from `dev` value.
The returned list should contain only the pod names and nothing else.
`kubectl get pods -l 'env notin (dev)'`{{copy}}

