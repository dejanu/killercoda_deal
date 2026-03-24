
### CronJobs Params

* When our cron job runs a long-running process, what happens? How many jobs or pods does this cron trigger? 
``` 
kubectl create cronjob sleep-cron \
  --image=busybox \
  --schedule="*/1 * * * *" \
  -- sh -c "sleep 90; echo done"
```{{copy}}

* Inspect cron: `kubectl get cronjob sleep-cron -o yaml`{{copy}}. What can it be changed not allow overlapping execution? 


* Delete the cronjob and create a new one with the following specs:

```
kubectl create cronjob sleep-cron \
  --image=busybox \
  --schedule="* * * * *" \
  -- sh -c "sleep 120; echo done"
```

<details>
<summary>Hint</summary>

Since <code>concurrencyPolicy: Allow</code> it allows overlapping execution. Executions overlap when the job runs longer than the schedule interval.

<br>

Update the concurency policy, not allow concurrent runs: <code>  concurrencyPolicy: Forbid</code>
<br>

Rerun one of the cronjob's jobs aka create another job: <code>kubectl create job report-rerun --from=cronjob/report</code>
<br>

</details>