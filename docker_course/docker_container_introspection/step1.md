### Setup

Docker container image:


* A container image contains a packaged application, along with its dependencies, and information on what processes it runs when launched.

* Create the following Dockerfile

```bash
cat<<EOF>Dockerfile
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

* Build a docker image called `test`: `docker build -t test .`{{copy}} . What it is missing?

* Start container based on the image that you've build: `docker run --rm test`

* `docker save` your image aka produce a tarred repository to the standard output stream ( that contains all parent layers, and all tags + versions, or specified repo:tag) i.e. `test.tar`

* extract tarball: `mkdir oci && tar -xvf test.tar -C oci`{{copy}}

* Modify desired fields like **CMD**

* Recrete tarball: `cd oci && tar -cvf newtest.tar .`{{copy}} and load back the image `docker load -i newtest.tar`

* `docker run test` what are the differences? 🔍