
### Jobs and CronJobs

* Create a job that prints the date `kubectl create job one-off --image=alpine -- date`{{exec}}

* Create a cronjob that prints the date every minute, You can do it imperatively or declaratively.

* Rerun one of the cronjob's jobs. 

* Create a cronjob called `hello` that prints `Hello World` to STDOUT that runs in the next minute. Use `--schedule='min hour day month weekday'` flag and [crontab_guru](https://crontab.guru/#*/1_*_*_*)

<details>
<summary>Hint</summary>
Create cronjob imperatively: <code>kubectl create cronjob cronjob-example --schedule='*/1 * * * *' --image=alpine -- date</code> or declaratively: <code>kubectl apply -f cronjob.yaml</code>
<br>

Rerun one of the cronjob's jobs: <code>kubectl create job test --from=cronjob/cronjob-example</code>
<br>

Rerun one of the cronjob's jobs: <code>kubectl create cronjob hello --schedule='01 21 * * *' --image=alpine -- /bin/sh -c "echo Hello World" </code>
<br>

</details>