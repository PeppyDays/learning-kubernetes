# Command and Arguments

- Command overrides Entrypoint of docker image
- Args overrides Cmd of docker image

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: simple
  name: simple
spec:
  containers:
  - image: ubuntu
    name: ubuntu
    command:
    - /bin/sh
    - -c
    - sleep 100
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: simple
  name: simple
spec:
  containers:
  - image: ubuntu
    name: ubuntu
    command:
    - /bin/sh
    - -c
    args:
    - |
      echo run ..
      sleep 3600
```
