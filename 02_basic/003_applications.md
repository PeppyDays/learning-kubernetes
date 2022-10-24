# Applications

## Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: pod-nginx
  name: pod-nginx
spec:
  containers:
  - image: nginx
    name: nginx
```

## Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: deploy-nginx
  name: deploy-nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: po-nginx
  template:
    metadata:
      labels:
        app: po-nginx
    spec:
      containers:
      - name: nginx
        image: nginx
```

Deployment creates many resources - pods, replicaset and deployment. Deployment supports software update and rollback. Replicaset is responsible of scaling and rolling pods.

## Job

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: test-job
spec:
  # completions: 3
  parallelism: 3
  ttlSecondsAfterFinished: 30
  template:
    spec:
      containers:
      - image: ubuntu
        name: test-job
        command:
        - sleep
        - "100"
      restartPolicy: Never
```

Job runs one-time and is completed. completions runs pods in serial, on contrast, parallel runs pods in parallel. ttlSecondsAfterFinished defines the lift limit after finishing the job. This terminates the pod automatically. If not defined, the pod remains with Completed status.

## Cron Job

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: test-cron-job
spec:
  schedule: 0/5 * * * ?
  successfulJobsHistoryLimit: 10
  jobTemplate:
    metadata:
      name: test-cron-job
    spec:
      template:
        parallelism: 2
        spec:
          containers:
          - image: ubuntu
            name: test-cron-job
            command:
            - echo hi
          restartPolicy: Never
```

Cron job is a wrapper of job with scheduling. By default, 3 historical pods remain, and the number can be adjusted by successfulJobsHistoryLimit.

## Daemon Set

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app: ds-nginx
  name: ds-nginx
spec:
  selector:
    matchLabels:
      app: pod-nginx
  template:
    metadata:
      labels:
        app: pod-nginx
    spec:
      containers:
      - image: nginx
        name: nginx
```
