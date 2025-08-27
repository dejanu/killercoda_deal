### Setup

Building images flavours ... `docker build .`


* Docker builds images by reading the instructions from a Dockerfile. A Dockerfile is a text file containing instructions for building your source code.

* List the current directory files, it is possible to build a image with the current setup?

* Yes if we do: `docker build -t demo https://github.com/dejanu/sretoolkit.git#remotebuild:docker_stuff --no-cache`{{copy}} ... uploads the entire build context to the docker daemon 

* What is a **build-context**? The build context is the set of files that your build can access.
We're passing a URL as a build context more exactly `docker_stuff` directory from `sretoolkit` repo and `remotebuid` branch.

* The default filename to use for a Dockerfile is `Dockerfile`, another common convention is to use 
`something.Dockerfile`

```bash
cat<<EOF>dev.Dockerfile
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

* Now we can do: `docker build -f dev.Dockerfile .`...don't forget about `test.py`
