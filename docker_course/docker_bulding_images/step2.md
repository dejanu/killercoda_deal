### Setup

Images layers...creating images from containers


* Sometimes it can be useful to commit a container's file changes or settings into a new image aka creating an new image based on a running container

* Start a container based on minimal python image and spawn interactive terminal:
`docker run --rm --name=baseimage -ti --entrypoint=/bin/sh python:3.9.22-alpine`{{copy}}

* Within the interactive session create a file

```bash
 cat<<EOF>test.py
 #!$(which python)
 print("Sallot")
 EOF
```

* Open a new tab/terminal, and create a **new image layer manually**: `docker container commit -m "Add script" baseimage newimage`{{copy}}

* Start a new container, based on the newly created image: `docker run --entrypoint=/tmp/test newimage`