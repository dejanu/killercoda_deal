
### Thanos Overview

Prometheus isn't meant for long-term storage. Prometheus does NOT do any replication, and if the TSDB is lost, the user is expected to shrug, mumble, "Oh well," and restart Prometheus.

Thanos is a system of microservices designed to **scale** Prometheus. Concretely, it is a single binary capable of running in different modes.

```
thanos sidecar --> Runs alongside Prometheus; exposes its data through Thanos StoreAPI and optionally uploads TSDB blocks to object storage.

thanos query --> Aggregates metrics from multiple sources and exposes a Prometheus-compatible PromQL API.

thanos store --> Reads historical metric blocks from object storage and makes them queryable.

thanos compact --> Compacts, downsamples and applies retention policies to historical data.

thanos rule --> Evaluates recording and alerting rules against Thanos data.

query-frontend --> Caches and splits queries before forwarding them to Query
```