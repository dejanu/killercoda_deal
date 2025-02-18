#!/bin/bash

# pull image
docker pull dejanualex/dockersay:2.1

# pull deployment
curl https://raw.githubusercontent.com/dejanu/killercoda_deal/main/course/init_container/deployment.yaml -o deployment.yaml