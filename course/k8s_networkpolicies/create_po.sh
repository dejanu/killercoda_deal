# create test ns
kubectl create ns test

# create web-server (nginx) in test ns
kubectl run web-server -n test -l app-tier=web --image=nginx --port=80