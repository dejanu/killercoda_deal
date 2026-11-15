## Cardinality of Prometheus Setup

A good metric to check the cardinality of a Prometheus instance is `prometheus_tsdb_head_series`. This metric shows the number of series currently in the TSDB head. 

Query each Prometheus instance for this metric `prometheus_tsdb_head_series` and sum the results to get the total number of series across all Prometheus instances. 