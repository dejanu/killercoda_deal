## Cardinality of Prometheus Setup

A good metric to check the cardinality of a Prometheus instance is `prometheus_tsdb_head_series`. This metric shows the number of series currently in the TSDB head. 

**How many series (metrics) we collect overall on all Prometheus instances we have?** Query for for `prometheus_tsdb_head_series` metric.

<details>
<summary>Answer</summary>
The **total number of series** across all Prometheus instances can be obtained by summing the values of the `prometheus_tsdb_head_series` metric from each instance.

The series scraped by those two US Prometheus instances are identical, and if we simply sum the values from all three Prometheus instances, we will double-count the series from the US cluster. 

total series = series per target * 5
unique series = series per target * 3
</details>

## Thanos Sidecars