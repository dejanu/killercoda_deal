
### Objects: minimal access

* Check available kinds for RBAC: `kubectl api-resources --api-group=rbac.authorization.k8s.io`{{copy}}. Check roles `kubectl get role`{{copy}} and rolebinding `kubectl get rolebindings`{{copy}}

* Good baseline check for RBAC: `kubectl auth can-i <verb> <resource> --as=<identity>`{{copy}}

* Create a service account : `kubectl create sa dev-sa`{{copy}} try to use it and list the pods in the default namespace:

* Next the service accounts needs a ...? set of permissions.

* Bind the role to the service account.

* Create `dev` namespace: `kubectl create ns dev`{{copy}} test the service account for this ns: `kubectl auth can-i list pods
  --as=system:serviceaccount:default:dev-sa -n dev`{{copy}}

* Create `rbac-test` pod that uses `dev-sa` service account: `kubectl exec -it rbac-test -- sh`{{copy}} and  `kubectl get pods`{{copy}}

<details>
<summary>Hint</summary>
Test the actions/verbs for  dev-sa service account: <code>kubectl auth can-i get pods --as=system:serviceaccount:default:dev-sa</code> 
<br>

- Create role pod-reader for the dev-sa service account (⚠️ Roles are namespace-scoped):
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

- Create a RoleBinding for Service Account and Role:
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

- Create a ClusterRole 

```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: pod-reader-global
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
```

<br>

- Create a RoleBinding for Service Account and ClusterRole 😉:
```
kind: ClusterRoleBinding
metadata:
  name: global-read
subjects:
- kind: ServiceAccount
  name: dev-sa
  namespace: default
roleRef:
  kind: ClusterRole
  name: pod-reader-global
  apiGroup: rbac.authorization.k8s.io
```
<br>

- Create a pod that uses <code>dev-sa</code> service account:

```
apiVersion: v1
kind: Pod
metadata:
  name: rbac-test
spec:
  serviceAccountName: dev-sa
  containers:
  - name: test
    image: bitnami/kubectl
    command: ["sleep", "3600"]
```
 
</details>