kubectl create ns playground
kubectl create deployment nginx --image=nginx -n playground --replicas=2

# create rbac stuff
cat<<EOF>rbac.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: scaler
  namespace: playground

---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: deployment-scaler
  namespace: playground
rules:
- apiGroups: ["apps"]
  resources: ["deployments", "deployments/scale"]
  verbs: ["get", "patch"]

---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: deployment-scaler-binding
  namespace: playground
subjects:
- kind: ServiceAccount
  name: scaler
  namespace: playground
roleRef:
  kind: Role
  name: deployment-scaler
  apiGroup: rbac.authorization.k8s.io
EOF
