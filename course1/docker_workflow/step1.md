
### Docker workflow

* Docker provides the ability to package and run an application in a loosely isolated environment called a **container**, and streamlines the development lifecycle by allowing standardized environments using local containers.

![Scan results](./assets/workflow.png)

* A Dockerfile contains instructions that are used to build Docker **images**.

* An **image** is a read-only template that provides instructions for creating a Docker containe, it consists a combination of a JSON manifest and individual layer files.

* A **container** is a runnable instance of an image.

* Let's take a simple example and containerize an app from our machine: `file /usr/games/cowsay`{{exec}}

* **cowsay** is a Perl capable of creating ASCII art representations featuring a cow along with a custom message, `/usr/games/cowsay helloo`{{exec}}

* Let's create a Dockerfile:

```bash
cat<<EOF>>Dockerfile
FROM ubuntu:14.04

# install cowsay: "cowsay" default installs to /usr/games
RUN apt-get update && apt-get install -y cowsay --no-install-recommends \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
ENV PATH $PATH:/usr/games

ENTRYPOINT ["cowsay"]
CMD ["Hello World!"]
EOF
```{{exec}}

* Build image  `cowsayimage`, using as a build context the current directory containing the **Dockerfile**:
`docker build -t cowsayimage .`{{exec}}

* Check images `docker images | grep cowsayimage`{{exec}} and start a container based on `cowsayimage`: `docker run cowsayimage`{{exec}}