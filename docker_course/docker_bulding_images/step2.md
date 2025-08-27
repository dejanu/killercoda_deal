### Setup

Images layers...creating images from containers


* Sometimes it can be useful to commit a container's file changes or settings into a new image aka **creating an new image based on a running container**.

* Start a container based on minimal python image and spawn interactive terminal:
`docker run --rm --name=baseimage -ti --entrypoint=/bin/sh python:3.9.22-alpine`{{copy}}

* Within the interactive session create a file:

```bash
 cat<<EOF>/tmp/test.py
#!$(which python3)
print("Sallot")
EOF
```

* Open a new tab/terminal, and create a **new image layer manually** based on the running baseimage container `docker ps` : `docker container commit -m "Add script" baseimage newimage`{{copy}}

* Start a new container, based on the newly created image: `docker run --entrypoint=/tmp/test.py newimage`

* Inspect layers, where in `blobs/sha256/` dir each file is a layer blob from the image (gzipped tarballs)

First: `docker save newimage -o newimage.tar`{{copy}} then `mkdir oci && tar -xvf newimage.tar -C oci`{{copy}} and last inside `oci` dir search in blobs for `test.py` file: `for b in blobs/sha256/*;do echo "$b";tar -tf "$b" | grep test;done`{{copy}}
`