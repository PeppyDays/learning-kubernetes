# JSON Path

## Basic

### Attributes

```json
{
  "vehicles": {
    "car": {
      "color": "blue",
      "price": 20000
    },
    "bus": {
      "color": "white",
      "price": 20000
    }
  }
}
```

```jsonpath
$.vehicles.car
$.vehicles.bus.color
```

### Lists

```json
[
  "car",
  "bus",
  "truck"
]
```

```jsonpath
$[0]
$[0,2]
$[0:1]
$[-1:]
$[-3:]
```

## Criteria

```json
[12, 43, 23, 12, 56, 43]
```

```jsonpath
$[?(@ > 40)]
$[?(@ == 12)]
$[?(@ != 12)]
$[?(@ in [40, 35])]
$[?(@ nin [40, 35])]
```

## Wild Card

```json
{
  "vehicles": {
    "car": {
      "color": "blue",
      "price": 20000
    },
    "bus": {
      "color": "white",
      "price": 20000
    }
  }
}
```

```jsonpath
$.*.color
$.*.price
```

```json
[
  {
    "model": "ABC",
    "location": "front"
  },
  {
    "model": "DEF",
    "location": "back"
  }
]
```

```jsonpath
$[*].model
$[*].location
```

## JSON Path in Kubernetes

`$` is not mandatory because kubectl adds it.

```bash
k get po -o json

  {
      "apiVersion": "v1",
      "items": [
          {
              "apiVersion": "v1",
              "kind": "Pod",
              "metadata": {
                  "annotations": {
                      "cni.projectcalico.org/containerID": "b86ae0ed97414fcae167bc5cbd939af60c530b0cabe889c06f390c1f0fb8cd74",
                      "cni.projectcalico.org/podIP": "10.244.188.159/32",
                      "cni.projectcalico.org/podIPs": "10.244.188.159/32",
                      "kubectl.kubernetes.io/restartedAt": "2022-11-01T02:31:11+09:00"
                  },
                  "creationTimestamp": "2022-10-31T17:31:11Z",
                  "generateName": "deploy-rollout-f5c5f94bf-",
                  "labels": {
                      "app": "deploy-rollout",
                      "pod-template-hash": "f5c5f94bf"
                  },
  ..

k get po -o=jsonpath='{.items[0].spec.containers[0].image}'

  nginx:1.20.1

k get po -o=jsonpath='{.items[*].spec.containers[*].image}'

  nginx:1.20.1 nginx:1.20.1 nginx:1.20.1

k get no -o=jsonpath='{.items[*].metadata.name}{"\n"}{.items[*].status.capacity.cpu}'

  kube-master kube-worker-01 kube-worker-02
  2 2 2

k get no -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.capacity.cpu}{"\n"}{end}'

  kube-master     2
  kube-worker-01  2
  kube-worker-02  2

k get no -o=custom-columns='NODE:.metadata.name,CPU:.status.capacity.cpu'

  NODE             CPU
  kube-master      2
  kube-worker-01   2
  kube-worker-02   2

k get no --sort-by=.metadata.name

k get no --sort-by=.status.capacity.cpu
```
