# Others

## Config Map

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: sleepy-config
data:
  STATUS: "WAKE UP"
  NOTE: "Test Configuration"
---
apiVersion: v1
kind: Pod
metadata:
  name: sleepy-pod-1
  labels:
    run: sleepy-pod-1
spec:
  containers:
  - image: nginx
    name: sleepy-container
    envFrom:
    - configMapRef:
        name: sleepy-config
---
apiVersion: v1
kind: Pod
metadata:
  name: sleepy-pod-2
  labels:
    run: sleepy-pod-2
spec:
  containers:
  - image: nginx
    name: sleepy-container
    env:
    - name: APP_STATUS
      valueFrom:
        configMapKeyRef:
          name: sleepy-config
          key: STATUS
---
apiVersion: v1
kind: Pod
metadata:
  name: sleepy-pod-3
  labels:
    run: sleepy-pod-3
spec:
  containers:
  - image: nginx
    name: sleepy-container
    volumeMounts:
    - name: sleepy-config-volume
      mountPath: /etc/sleepy.d
  volumes:
  - name: sleepy-config-volume
    configMap:
      name: sleepy-config
```

ConfigMap K/V can be injected to environment variables and volume files.

## Secret

```bash
$ echo -n 'root' | base64
cm9vdA==

$ echo -n 'welcome' | base64
d2VsY29tZQ==

$ echo -n cm9vdA== | base64 --decode
root

$ echo -n d2VsY29tZQ== | base64 --decode
welcome
```

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysql-cred
  namespace: default
type: Opaque
data:
  username: cm9vdA==
  password: d2VsY29tZQ==
```

```bash
k create secret generic mysql-cred --from-literal=username='root' --from-literal=password='welcome'
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-pod
  labels:
    run: secret-pod
spec:
  containers:
  - name: secret-container
    image: nginx
    env:
    - name: MYSQL_ROOT_PASSWORD
      valueFrom:
        secretKeyRef:
          name: mysql-cred
          key: password
```

## Rolling Update

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: deploy-rollout
spec:
  replicas: 3
  strategy:
    type: RollingUpdate

  selector:
    matchLabels:
      app: deploy-rollout
  template:
    metadata:
      labels:
        app: deploy-rollout
    spec:
      containers:
      - name: nginx
        image: nginx:1.20.1
```

```bash
k set image deployment deploy-rollout nginx=nginx:1.21.0
```

## Kustomize and Helm

Later..
