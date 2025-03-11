### Deploy it to k8s

* Try-it on your local machine [repo here](https://hub.docker.com/repository/docker/dejanualex/dockersay/general)
`docker run --rm dejanualex/dockersay:1.0`{{copy}} for arm64 and `docker run --rm dejanualex/dockersay:2.0`{{copy}} for amd64.

* You have a vanilla k8s cluster at hand: `kubectl get no`{{copy}} with no pod running in the default namespace `kubect get po`{{copy}}, **deploy** the cowsay app, knowing that is available in Docker Hub container registry.

<details>
<summary>Hint</summary>
 Create pod <code>kubectl run test --image=dejanualex/dockersay:2.0</code> or create deployment <code>kubectl create deployment test --image=dejanualex/dockersay:2.0</code>
 <br>
Don't forget about <code>kubectl logs <pod></code>
</details>