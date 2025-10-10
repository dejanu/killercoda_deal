kubectl create ns playground
kubectl -n playground run basic --image=nginx:stable-alpine-perl --restart=OnFailure --port=80