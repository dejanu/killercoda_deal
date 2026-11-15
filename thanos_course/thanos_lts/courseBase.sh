#!/usr/bin/env bash

docker pull dejanualex/minio:2024-12-18T13-15-44Z 
docker pull quay.io/prometheus/prometheus:v2.38.0
docker pull quay.io/thanos/thanos:v0.28.0
docker pull quay.io/thanos/thanosbench:v0.2.0-rc.1

mkdir /root/editor
