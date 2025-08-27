
### Docker Image play


* Create app, using here-doc (feed the inline text block as STDIN to cat and redirect the output to test):

```bash
cat<<EOF>test.py
#!$(which python)
print("Hello")
EOF
```{{exec}}

* Dockerfile just a convention 
```bash
cat<<EOF>newDockerfile
# Python runtime as a parent image
FROM python:slim-bullseye

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY test.py /app

# Run app.py when the container launches
CMD ["python","test.py"]
EOF
```{{exec}}

* Build image: `docker build -t demo -f newDockerfile .`

* Run image: `docker run --rm demo`

* Save image: `docker image save demo -o test.tar` (Produces a tarred repository to the standard output stream. Contains all parent layers, and all tags + versions, or specified repo:tag)

* Extract tarball: `mkdir oci && tar -xvf newtest.tar -C oci`

* Modify config file i.e.`0f92e657c4b00a3725248ae4d0f86598365eef679594c792a6093f5c4f06310a.json` (DO MAGIC HERE: CMD and Created)

* Recreate tarball: `cd oci && tar -cvf test.tar .`

* Spin up container with new image: `docker rmi demo  && docker load -i newtest.tar` and then `docker run`

* Use `--format` Go template to show the manipulated docker image, where  `.CreatedSince` is the elapsed time since the image was created and `.CreatedAt` is the time when the image was created:  `docker images --format "{{.Repository}}:{{.Tag}} {{.CreatedSince}} --> {{.CreatedAt}}"`

* Inspect image
```bash
# inspect image
docker inspect -f '{{.Config.Cmd}}' demo
docker inspect -f '{{.Config.Entrypoint}}' demo
docker run -it --entrypoint ls  demo
```

* That's important to not use tags and use digest SHA hash:

```bash
docker images --digest
```