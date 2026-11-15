## Querier

Now that we have setup Sidecar for one or more Prometheus instances, we want to use Thanos’s global Query Layer to evaluate PromQL queries against all instances at once.

The Querier component is stateless and horizontally scalable, and can be deployed with any number of replicas.