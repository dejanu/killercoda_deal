### Setup

Building images flavours ... `docker build .`


* Docker builds images by reading the instructions from a Dockerfile. A Dockerfile is a text file containing instructions for building your source code.

* List the current directory files, it is possible to build a image with the current setup? Check **Hint** 😉.

* Inspect/run the image.

* What is a **build-context**? The **build context is the set of files that your build can access**.
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

* Now we can do: `docker build someimage -f dev.Dockerfile .`...don't forget about `test.py`


<details>
<summary>Hint</summary>
The positional argument that you pass to the build command specifies the context that you want to use for the build so YES, we can use a remote build context such as a github remote repo: <code>docker build -t demo https://github.com/dejanu/sretoolkit.git#remotebuild:docker_stuff --no-cache</code>

We're passing a URL as a build context more exactly <code>docker_stuff</code> directory from <code>sretoolkit</code> repo and <code>remotebuid</code> branch.
</details>

