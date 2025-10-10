# create deployment
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
