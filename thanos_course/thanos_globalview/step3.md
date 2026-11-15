## Querier/Query

Now that we have setup Sidecar for one or more Prometheus instances, we want to use Thanos’s global Query Layer to evaluate PromQL queries against all instances at once.

The Querier component is stateless and horizontally scalable, and can be deployed with any number of replicas. 

The Querier component is essentially a vanilla **PromQL engine** that fetches the data from any service
that implements Thanos [StoreAPI](https://thanos.io/tip/thanos/integrations.md/#storeapi).

Start the queries:

```bash
docker run -d --net=host --rm \
    --name querier \
    quay.io/thanos/thanos:v0.42.5 \
    query \
    --http-address 0.0.0.0:29090 \
    --query.replica-label replica \
    --endpoint 172.17.0.1:19190 \
    --endpoint 172.17.0.1:19191 \
    --endpoint 172.17.0.1:19192 && echo "Started Thanos Querier"
```{{execute}}

Thanos Querier exposes very similar UI to the Prometheus, but on top of many StoreAPIs you wish to connect to.

To check if the Querier works as intended let's look on [Querier UI `Store` page]({{TRAFFIC_HOST1_29090}}/stores).

**Querier is capable of deduplicating StoreAPIs that are in the same HA group**