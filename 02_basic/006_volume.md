# Volume

## Empty Directory

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-emptydir
  labels:
    app: nginx
spec:
  containers:
  - name: web-page
    image: nginx
    volumeMounts:
    - mountPath: /usr/share/nginx/html
      name: empty-directory
  - name: html-builder
    image: alpine
    volumeMounts:
    - mountPath: /html-dir
      name: empty-directory
    command: ["/bin/sh", "-c"]
    args:
      - echo "This page created on $(date +%Y-%m-%d)" > /html-dir/index.html;
        sleep infinity;
  volumes:
  - name: empty-directory
    emptyDir: {}
```

Share a volume within a pod.

## Host Path

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: ds-hostpath
  labels:
    app: ds-hostpath
spec:
  selector:
    matchLabels:
      app: ds-hostpath
  template:
    metadata:
      labels:
        app: ds-hostpath
    spec:
      containers:
      - name: host-mon
        image: sysnet4admin/sleepy
        volumeMounts:
        - mountPath: /host-log
          name: hostpath-directory
      volumes:
      - name: hostpath-directory
        hostPath:
          path: /var/log
```

Mount host directory to a pod.

## NFS

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: deploy-nfs
  labels:
    app: deploy-nfs
spec:
  replicas: 3
  selector:
    matchLabels:
      app: deploy-nfs
  template:
    metadata:
      labels:
        app: deploy-nfs
    spec:
      containers:
      - name: chk-log
        image: sysnet4admin/chk-log
        volumeMounts:
        - name: nfs-vol
          mountPath: /audit
      volumes:
      - name: nfs-vol
        nfs:
          server: 192.168.56.10
          path: /mnt/share
```

Mount NFS to a pod.

## PV and PVC

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-nfs
spec:
  capacity:
    storage: 100Mi
  accessModes:
  - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    server: 192.168.56.10
    path: /mnt/share
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-nfs
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 10Mi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: deploy-pvc
  labels:
    app: deploy-pvc
spec:
  replicas: 3
  selector:
    matchLabels:
      app: deploy-pvc
  template:
    metadata:
      labels:
        app: deploy-pvc
    spec:
      containers:
      - name: chk-log
        image: sysnet4admin/chk-log
        volumeMounts:
        - name: pvc-vol
          mountPath: /audit
      volumes:
      - name: pvc-vol
        persistentVolumeClaim:
          claimName: pvc-nfs
```

## Storage Class and PVC

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-dynamic
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 100Mi
  storageClassName: nfs-client
```

NFS storage class is already installed. By just issueing pvc, pv is created automatically by storage class. When deleting the pvc, the bounded pv is deleted automatically (depending on sc configuration).
