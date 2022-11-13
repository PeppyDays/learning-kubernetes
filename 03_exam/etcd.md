# ETCD

## Snapshot Save

Find certificate files used in API server configuration.

```bash
cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep -i etcd

    - --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt
    - --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt
    - --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key
    - --etcd-servers=https://127.0.0.1:2379
```

```bash
export ETCDCTL_API=3

etcdctl snapshot save /opt/etcd-backup.db \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key
```

## Snapshot Restore

Restore the snapshot to the other directory /var/lib/etcd_restore.

```bash
etcdctl snapshot restore /tmp/etcd-backup.db \
--data-dir=/var/lib/etcd_restore \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key
```

After that, check etcd static pod's manifest and change data-dir to /var/lib/etcd_restore. Then, boost up all static manifests. By doing so, the snapshot version will be restored.
