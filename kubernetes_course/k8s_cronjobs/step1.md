
### Jobs and CronJobs

* Create a job that prints the date `kubectl create job one-off --image=alpine -- date`{{exec}}

* Create a cronjob that prints the date every minute, You can do it imperatively or declaratively.

* Rerun one of the cronjob's jobs. 


<details>
<summary>Hint</summary>
Create cronjob imperatively: <code>kubectl create cronjob cronjob-example --schedule='*/1 * * * *' --image=alpine -- date</code> or declaratively: <code>kubectl apply -f cronjob.yaml</code>
<br>

Rerun one of the cronjob's jobs: <code>kubectl create job test --from=cronjob/cronjob-example</code>
<br>
</details>