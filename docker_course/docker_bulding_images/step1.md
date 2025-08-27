### Setup

Building images flavours


* Docker builds images by reading the instructions from a Dockerfile. A Dockerfile is a text file containing instructions for building your source code.

* List the current directory files, it is possible to build a image with the current setup?

* Yes if we do: `docker build -t demo https://github.com/dejanu/sretoolkit.git#remotebuild:docker_stuff --no-cache`{{copy}}

* What is a **build-context**? The build context is the set of files that your build can access.
We're passing a URL as a build context more exactly `docker_stuff` directory from `sretoolkit` repo and `remotebuid` branch.
