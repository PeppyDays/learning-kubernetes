# Node

## Cordon and Drain

```bash
k cordon kube-worker-01
k uncordon kube-worker-01
k drain kube-worker-01 --ignore-daemonsets
```

## Node Name

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nodename
spec:
  containers:
  - name: nginx
    image: nginx
  nodeName: kube-worker-02
```

Choose deployed node by setting nodeName.

## Node Label and Node Selector

```bash
k get no --show-labels
k label node kube-worker-01 input=test
k get no -l input=test
k label node kube-worker-01 input-
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx
  name: nginx
spec:
  replicas: 5
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx
        name: nginx
      nodeSelector:
        input: test
```

By setting nodeSelector in pod template, the pods are deployed into nodes that has the same labels.

## Node Affinity

to do later

## Taints and Tolerations

```bash
k get no kube-master -o yaml | grep -i taints -F5
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx
  name: nginx
spec:
  replicas: 5
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx
        name: nginx
      tolerations:
      - effect: NoSchedule
        key: node-role.kubernetes.io/master
      - effect: NoSchedule
        key: node-role.kubernetes.io/control-plane
```
