
### PostgreSQL database with a StatefulSet

* Create a StatefulSet that manages a PostgreSQL database with persistent storage. Run the following command to create the StatefulSet:

```bash
cat <<EOF>postgres-statefulset.yaml
# StatefulSet for PostgreSQL
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgres
spec:
  serviceName: "postgres"
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
      - name: postgres
        image: postgres:15
        ports:
        - containerPort: 5432
          name: postgres
        env:
        - name: POSTGRES_PASSWORD
          value: "mysecretpassword"
        - name: POSTGRES_USER
          value: "admin"
        - name: POSTGRES_DB
          value: "mydb"
        - name: PGDATA
          value: /var/lib/postgresql/data/pgdata
        volumeMounts:
        - name: postgres-storage
          mountPath: /var/lib/postgresql/data
EOF
```{{exec}}

* Apply the StatefulSet configuration `kubectl apply -f postgres-statefulset.yaml`{{exec}} , what is the status of the StatefulSet? `kubectl get statefulsets`{{exec}} , ` kubectl  describe sts postgres`{{exec}}

* Scale the sts and connect to the PostgreSQL database running in the pod:
`kubectl run -it --rm psql-client --image=postgres:15 --restart=Never --env="PGPASSWORD=mysecretpassword" -- psql -h postgres-0.postgres.default.svc.cluster.local -U admin -d mydb`{{exec}} What happens? List databases: `\l+`{{copy}} 


<details>
<summary>Hint</summary>
Without volumeClaimTemplates the pods will be failed to start: <code>spec.containers[0].volumeMounts[0].name: Not found: "postgres-storage"</code>. Create the sts with <code>kubectl apply -f postgres-good-statefulset.yaml</code> 
<br>

Create a headless service for the sts: <code>kubectl apply -f postgres-service.yaml</code>
<br>
</details>