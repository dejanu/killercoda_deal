# Intro: Downsampling and unlimited metric retention for Prometheus

They say that [Thanos](thanos.io) is a set of components that can be composed into a highly available metric system with **unlimited storage capacity**
and that it can be added **seamlessly** on top of existing Prometheus deployments.



Steps:

* How to start uploading your Prometheus data seamlessly to cheap object storage thanks to Thanos sidecar.
* How to further query your data in object storage thanks to Thanos Store Gateway.
* How to query both fresh and older data in easy way through Thanos Querier.

All of this allows you to keep your metrics in cheap and reliable object storage, allowing virtually unlimited metric retention for Prometheus.

> NOTE: This course uses docker containers with pre-built Thanos, Prometheus, and Minio Docker images available publicly.
