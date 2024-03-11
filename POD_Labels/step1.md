
### Explore labels

* Check all pods running in the `default` namespace:
`kubectl get po --show-labels`{{exec}}

* List all pods with label `env`:
`kubectl get po -L env`

### Select pods based on label

* Get a list of all pod names running in the rep namespace which have their colour label set to either orange, red, or yellow. 
The returned pod name list should contain only the pod names and nothing else:
```bash
kubectl get po -l "colour in (red,orange,yellow)" -oname
```