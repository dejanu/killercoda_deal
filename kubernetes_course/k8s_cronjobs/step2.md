
### CronJobs Params

* When our cron job runs a long-running process, what happens? How many jobs or pods does this cron trigger? 
``` 
kubectl create cronjob sleep-cron \
  --image=busybox \
  --schedule="*/1 * * * *" \
  -- sh -c "sleep 90; echo done"
```{{copy}}

* Inspect cron: `kubectl get cronjob sleep-cron -o yaml`{{copy}}

* Create a cronjob called `report` that prints `Sending Report` to STDOUT that runs in the next minute. Next you need to send another report but 
you cannot wait until next day, what are the options?

<details>
<summary>Hint</summary>

Since <code>concurrencyPolicy: Allow</code> it allows overlapping execution.

<br>

Create hello cronjob <code>kubectl create cronjob report --schedule='01 21 * * *' --image=alpine -- /bin/sh -c "echo Sending Report" </code>
<br>

Rerun one of the cronjob's jobs aka create another job: <code>kubectl create job report-rerun --from=cronjob/report</code>
<br>

</details>