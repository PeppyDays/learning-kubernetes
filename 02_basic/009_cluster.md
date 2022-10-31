# Cluster

## Authorization

```bash
k describe pod -n kube-system kube-apiserver-kube-master | grep -i authorization -F3
      kube-apiserver
      --advertise-address=192.168.56.10
      --allow-privileged=true
      --authorization-mode=Node,RBAC
      --client-ca-file=/etc/kubernetes/pki/ca.crt
      --enable-admission-plugins=NodeRestriction
      --enable-bootstrap-token-auth=true
```

- Node: 스케쥴된 노드의 kubelet에서 인가를 결정함
- RBAC: 역할기반접근제어, 정해진 롤 또는 사용자가 지정한 롤을 이용해서 인가를 제어함

## Role, Role Binding and Service Account

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: dev
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: arine
  namespace: dev
---
apiVersion: v1
kind: Namespace
metadata:
  name: stage
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: kyle
  namespace: stage
```

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: dev
  name: role-get-dev
rules:
- apiGroups: ["*"]
  resources: ["pods", "deployments"]
  verbs: ["get", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: role-binding-dev-get-arine
  namespace: dev
subjects:
- kind: ServiceAccount
  name: arine
  apiGroup: ""
roleRef:
  kind: Role
  name: role-get-dev
  apiGroup: rbac.authorization.k8s.io
```

## Resource Quota

Set resource quota on a namespace. But put it later.

## Limit Range

Limit ranges (e.g. cpu request, ..) to pods in a namespace.

## Network Policy

..
