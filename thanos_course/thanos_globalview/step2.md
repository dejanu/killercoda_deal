## Cardinality of Prometheus Setup

A good metric to check the cardinality of a Prometheus instance is `prometheus_tsdb_head_series`. This metric shows the number of series currently in the TSDB head. 

**How many series (metrics) we collect overall on all Prometheus instances we have?** Query for for `prometheus_tsdb_head_series` metric.

<details>
<summary>Answer</summary>
The total number of series across all Prometheus instances can be obtained by summing the values of the `prometheus_tsdb_head_series` metric from each instance.

The series scraped by those two US Prometheus instances are identical, and if we simply sum the values from all three Prometheus instances, we will double-count the series from the US cluster. 

<code>
total series = series per target * 5
unique series = series per target * 3
</code>
</details>

## Thanos Sidecars

Thanos is a single Go binary capable to run in different modes. Each mode represents a different **component** and can be invoked in a single command. Let's take a look at all the Thanos commands:

```bash
docker pull quay.io/thanos/thanos:v0.42.5 --help
```{{execute}}

Sidecar as the name suggests should be deployed together with Prometheus. Primarely  Sidecar exposes Prometheus metrics as a common Thanos [StoreAPI](https://thanos.io/tip/thanos/integrations.md/#storeapi). StoreAPI
is a generic gRPC API allowing Thanos components to fetch metrics from various systems and backends.

### Adding sidecar to "EU1" Prometheus

```
docker run -d --net=host --rm \
    -v $(pwd)/prometheus0_eu1.yml:/etc/prometheus/prometheus.yml \
    --name prometheus-0-sidecar-eu1 \
    -u root \
    quay.io/thanos/thanos:v0.42.5 \
    sidecar \
    --http-address 0.0.0.0:19090 \
    --grpc-address 0.0.0.0:19190 \
    --reloader.config-file /etc/prometheus/prometheus.yml \
    --prometheus.url http://172.17.0.1:9090 && echo "Started sidecar for Prometheus 0 EU1"
```{{execute}}

### Adding sidecars to each replica of Prometheus in "US1"

```
docker run -d --net=host --rm \
    -v $(pwd)/prometheus0_us1.yml:/etc/prometheus/prometheus.yml \
    --name prometheus-0-sidecar-us1 \
    -u root \
    quay.io/thanos/thanos:v0.42.5 \
    sidecar \
    --http-address 0.0.0.0:19091 \
    --grpc-address 0.0.0.0:19191 \
    --reloader.config-file /etc/prometheus/prometheus.yml \
    --prometheus.url http://172.17.0.1:9091 && echo "Started sidecar for Prometheus 0 US1"
```{{execute}}

```
docker run -d --net=host --rm \
    -v $(pwd)/prometheus1_us1.yml:/etc/prometheus/prometheus.yml \
    --name prometheus-1-sidecar-us1 \
    -u root \
    quay.io/thanos/thanos:v0.42.5 \
    sidecar \
    --http-address 0.0.0.0:19092 \
    --grpc-address 0.0.0.0:19192 \
    --reloader.config-file /etc/prometheus/prometheus.yml \
    --prometheus.url http://172.17.0.1:9092 && echo "Started sidecar for Prometheus 1 US1"
```{{execute}}

Modify Prometheus scrape configuration to include our added sidecars.

```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s
  external_labels:
    cluster: eu1
    replica: 0

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['172.17.0.1:9090']
  - job_name: 'sidecar'
    static_configs:
      - targets: ['172.17.0.1:19090']
```{{copy}}

```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s
  external_labels:
    cluster: us1
    replica: 0

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['172.17.0.1:9091','172.17.0.1:9092']
  - job_name: 'sidecar'
    static_configs:
      - targets: ['172.17.0.1:19091','172.17.0.1:19092']
```{{copy}}

```
global:
  scrape_interval: 15s
  evaluation_interval: 15s
  external_labels:
    cluster: us1
    replica: 1

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['172.17.0.1:9091','172.17.0.1:9092']
  - job_name: 'sidecar'
    static_configs:
      - targets: ['172.17.0.1:19091','172.17.0.1:19092']
```{{copy}}

Since now Prometheus has access to sidecar metrics we can query for [`thanos_sidecar_prometheus_up`]({{TRAFFIC_HOST1_9090}}/graph?g0.expr=thanos_sidecar_prometheus_up&g0.tab=1)
to check if sidecar has access to Prometheus.