
### Jobs and CronJobs

* Create a job that prints the date `kubectl create job one-off --image=alpine -- date`{{exec}}

* Create a cronjob that prints the date every minute, You can do it imperatively or declaratively.

* Rerun a job:


<details>
<summary>Hint</summary>
Create cronjob imperatively: <code>kubectl -n jobs create cronjob cronjob-example --schedule='*/1 * * * *' --image=alpine -- date</code> or declaratively: <code>kubectl apply -f cronjob.yaml</code>
<br>

Create a headless service for the sts: <code>kubectl apply -f postgres-service.yaml</code>
<br>
</details>