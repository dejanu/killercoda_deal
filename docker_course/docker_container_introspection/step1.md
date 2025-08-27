### Setup

Docker engine ubuntu setup:

![Scan results](./assets/UFS.png)



* A container image contains a packaged application, along with its dependencies, and information on what processes it runs when launched.

* Create a the following Dockerfile

```bash
CAT<EOF>Dockerfile
# Python runtime as a parent image
FROM python:slim-bullseye

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY test.py /app

# Run app.py when the container launches
CMD ["python","test.py"]
EOF
```{exec}
