
### Objects

* Create a Small setup with k8s cronjobs to scale down deployments out of business hours.

* In `playground` namespace there is a deployment named `nginx` with 2 replicas. We need to scale down the deployment to 0 replicas out of business hours (you can decide when that is😉). `kubectl -n playground get po`{{copy}}

*  We need to create a cronjob that will scale down the deployment at 6pm and scale it back up to 2 replicas at 8am (based on https://hub.docker.com/r/bitnamisecure/kubectl image)

* Create cronjob named `scale-down` to scale down the deployment at 6pm:
```bash
cat<<EOF> scale-down-cronjob.yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: scale-down-nginx
  namespace: playground
spec:
  schedule: "0 18 * * *" # update this to your needs
  jobTemplate:
    spec:
      backoffLimit: 2
      template:
        spec:
          serviceAccountName: scaler
          containers:
          - name: scaler
            image: "bitnamisecure/kubectl:latest"
            command:
              - /bin/sh
              - -c
              - kubectl scale deploy nginx --replicas=0 -n playground
          restartPolicy: Never
EOF
```{{exec}}

* Guess what? We need to create a service account with the right permissions to scale the deployment.


<details>
<summary>Hint</summary>
We need to create a ServiceAccount a Role and a Rolebinding, inspect and apply: <code>kubectl apply -f rbac.yaml</code>
<br>
</details>