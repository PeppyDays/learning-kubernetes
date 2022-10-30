# Services

## Port Forwarding

```bash
$ k port-forward fwd-chk-hn 8080:80

    Forwarding from 127.0.0.1:8080 -> 80
    Forwarding from [::1]:8080 -> 80
```

By doing this, local address:port is redirected to the service port of a pod.

## Host Port and Host Network

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hp-chk-hn
spec:
  containers:
  - name: chk-hn
    image: sysnet4admin/chk-hn
    ports:
    - containerPort: 80
      hostPort: 8080
---
apiVersion: v1
kind: Pod
metadata:
  name: hnet-chk-hn
spec:
  hostNetwork: true
  containers:
    - name: chk-hn
      image: sysnet4admin/chk-hn
```

Host port connects pod's port to node's port. Host network automatically matches pod's port to node's port. Those are actually useless.

## Cluster IP

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app: ci-nginx
  name: ci-nginx
spec:
  type: ClusterIP
  selector:
    app: ci-nginx
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 80
```

Cluster IP is created, which is accessible only in the cluster. The cluster IP routes traffic to one of target pods.

## Node Port

```yaml
apiVersion: v1
kind: Service
metadata:
  name: np-nginx
spec:
  type: NodePort
  selector:
    app: np-nginx
  ports:
  - name: http
    protocol: TCP
    nodePort: 30000
    port: 8080
    targetPort: 80
```

Node:30000 > forward to ClusterIP:8080 > forwarded to one of pods:80

## Headless

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app: hl-nginx
  name: hl-nginx
spec:
  type: ClusterIP
  clusterIP: None
  selector:
    app: ci-nginx
  ports:
  - name: http
    protocol: TCP
    port: 8080
    targetPort: 8080
```

Same as cluster IP, but no dedicated internal IP assigned. This is only accessible by domain name. Headless is used with Stateful, which communicates via domain name and does not consume internal IP.

## Load Balancer

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app: app
  name: app
spec:
  type: LoadBalancer
  selector:
    app: app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
```

Get external IP from IP ranges configured in MetalLB, and route traffic to the selected pods via ClusterIP.

## Ingress

Before starting, need to install ingress controller.

```bash
-- install ingress nginx controller
-- https://kubernetes.github.io/ingress-nginx/deploy/#quick-start
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.4.0/deploy/static/provider/cloud/deploy.yaml
```

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - path: /hn
        pathType: Prefix
        backend:
          service:
            name: ing-hn
            port:
              number: 80
      - path: /ip
        pathType: Prefix
        backend:
          service:
            name: ing-ip
            port:
              number: 80
```

Ingress controller creates controller pods and service (in this case, load balancer). Client requests to the service's exposed IP. Ingress controller checks path and routes traffic to configured service and port. rewrite-target option removes the original path and just route with /.

With nginx ingress controller, ingressClassName should be specified as nginx-ingress.
