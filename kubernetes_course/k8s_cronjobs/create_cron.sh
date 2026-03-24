# create cron
cat > cronjob.yaml <<- "EOF"
apiVersion: batch/v1
kind: CronJob
metadata:
  name: cronjob-example
spec:
  schedule: "*/1 * * * *"
  successfulJobsHistoryLimit: 5  # default is 3
  failedJobsHistoryLimit: 5      # default is 1
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - image: alpine
            name: test
            command: ['date']
          restartPolicy: Never
EOF


# create cron that fails
cat > failcron.yaml <<- "EOF"
apiVersion: batch/v1
kind: CronJob
metadata:
  name: failing-cron
spec:
  schedule: "* * * * *"
  failedJobsHistoryLimit: 5 # default is 3
  successfulJobsHistoryLimit: 1
  jobTemplate:
    spec:
      backoffLimit: 1
      template:
        spec:
          containers:
          - name: fail
            image: busybox
            command: ["sh", "-c", "echo failing...; exit 1"]
          restartPolicy: Never
EOF
