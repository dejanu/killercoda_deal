#!/bin/bash

# Define the number of containers to start
num_containers=3

# Start containers
for ((i=1; i<=$num_containers; i++)); do
    docker run -d --name container$i alpine
done

# start container in background
docker run -d nginx:alpine-slim

docker run busybox:latest