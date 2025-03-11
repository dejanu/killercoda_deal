### Distribute image

![Scan results](./assets/dockertaxonomy.png)

* Registry: storing and distributing of container images and artifacts. Start a local registry based on Docker official [image](https://hub.docker.com/_/registry): `docker run -d -p 5000:5000 --restart always --name registry registry:2`{{exec}} check if it is running: `docker ps`{{exec}}

* Push the `cowsay` image to local registry, and check the repos from registry: `curl localhost:5000/v2/_catalog`{{copy}}

<details>
<summary>Hint</summary>
 Retag image <code>docker tag cowsayimage localhost:5000/cowsay:1.0</code> push it to registry: <code>docker push localhost:5000/cowsay:1.0</code>
</details>