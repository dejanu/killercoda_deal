
### PostgreSQL database with a StatefulSet

* Create a StatefulSet that manages a PostgreSQL database with persistent storage. Run the following command to create the StatefulSet:

```bash
cat <<EOF>> postgres-statefulset.yaml
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



