kubectl create ns playground
kubectl -n playground run basic --image=nginx:stable-alpine-perl --restart=OnFailure --port=80
kubectl -n playground create deploy notbasic --image=prom/prometheus:v3.15.1 --replicas=3