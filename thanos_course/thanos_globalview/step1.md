## Prometheus setup

We have the following Prometheus setup: 1 Prometheus server in some `eu1` cluster and 2 Prometheus servers in `us1` cluster. Let's spin up those Prometheus servers.

![Scan results](./assets/prometheus_setup.png)


* Create the data directories for Prometheus servers: `mkdir -p prometheus0_eu1_data prometheus0_us1_data prometheus1_us1_data`{{copy}}

* Create configuration for EU Prometheus server, `prometheus0_eu1.yml`:

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
```{{copy}}  

* Create configuration for US Prometheus server (first replica), `prometheus0_us1.yml`:

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
```{{copy}}

* Create configuration for US Prometheus server (second replica), `prometheus1_us1.yml`:

```yaml
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
```{{copy}}