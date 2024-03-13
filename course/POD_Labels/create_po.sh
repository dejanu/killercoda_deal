# array
pod_array=("app1" "app2")
for i in "${pod_array[@]}"; do kubectl run "$i" --image=nginx:mainline-alpine3.18-slim --labels="env=preprod";done
kubectl run app3 --image=nginx:mainline-alpine3.18-slim --labels="env=prod"
kubectl run app0 --image=nginx:mainline-alpine3.18-slim --labels="env=dev"