
### Objects: minimal access

* Check available kinds for RBAC: `kubectl api-resources --api-group=rbac.authorization.k8s.io`{{copy}} 

* Good baseline check for RBAC: `kubectl auth can-i <verb> <resource> --as=<identity>`{{copy}}

* Create a service account : `kubectl create sa dev-sa`{{copy}} try to use it and list the pods in the default namespace:

* Next the service accounts needs a ...? set of permissions.

* Bind the role to the service account.

<details>
<summary>Hint</summary>
Check dev-sa service account: <code>kubectl auth can-i get pods --as=system:serviceaccount:default:dev-sa</code>
<br>

Create role pod-reader for the dev-sa service account:
```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
  namespace: default
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list"]
```
<br>

Create a RoleBinding for Service Account and Role:
```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods-binding
  namespace: default
subjects:
- kind: ServiceAccount
  name: dev-sa
  namespace: default
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

</details>