# ETCD

## Snapshot

Find certificate files from `ps -ef | grep etcd` and put the file path into the commands.

```bash
export ETCDCTL_API=3

etcdctl snapshot save /opt/etcd-backup.db \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key
```
