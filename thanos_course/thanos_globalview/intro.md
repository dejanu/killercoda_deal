
### Thanos Overview

Prometheus isn't meant for long-term storage. Prometheus does NOT do any replication, and if the TSDB is lost, the user is expected to shrug, mumble, "Oh well," and restart Prometheus.

Thanos is a system of microservices designed to **scale** Prometheus. Concretely, it is a single binary capable of running in different modes.