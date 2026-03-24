
### CronJobs Params

* What happens when we our cron run a long running process, how many jobs/pods is the following cron running? 
``` 
kubectl create cronjob sleep-cron \
  --image=busybox \
  --schedule="* * * * *" \
  -- sh -c "sleep 90; echo done"
```
* Create a **cronjob** that prints the date every minute, You can do it imperatively or declaratively. . Use `--schedule='min hour day month weekday'` flag and [crontab_guru](https://crontab.guru/#*/1_*_*_*)

* Create a cronjob called `report` that prints `Sending Report` to STDOUT that runs in the next minute. Next you need to send another report but 
you cannot wait until next day, what are the options?

<details>
<summary>Hint</summary>
Create cronjob imperatively: <code>kubectl create cronjob cronjob-example --schedule='*/1 * * * *' --image=alpine -- date</code> or declaratively: <code>kubectl apply -f cronjob.yaml</code>

<br>

Create hello cronjob <code>kubectl create cronjob report --schedule='01 21 * * *' --image=alpine -- /bin/sh -c "echo Sending Report" </code>
<br>

Rerun one of the cronjob's jobs aka create another job: <code>kubectl create job report-rerun --from=cronjob/report</code>
<br>

</details>