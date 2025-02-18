
# create and set fake context
kubectl config set-cluster fake-cluster --server=https://127.0.0.1 --insecure-skip-tls-verify
kubectl config set-credentials fake-user --username=fake --password=testme
kubectl config set-context fake-context --cluster=fake-cluster --user=fake-user
kubectl config use fake-context
# move config file
mv ~/.kube/config ~/.kube/bkp.config