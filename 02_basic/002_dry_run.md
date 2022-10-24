# Dry Run and Output

```bash
# creates sample manifest
# make it start point for developing further
$ k run nginx --image=nginx -o yaml --dry-run=client > po_nginx.yaml

$ k create deploy nginx --image=nginx -o yaml --dry-run=client > deploy_nginx.yaml

$ k expose pod nginx --port 80 --target-port 80 --dry-run=client -o yaml > sample_cluster_ip.yaml

$ k create job test-job --image sysnet4admin/net-tools -o yaml --dry-run=client > test_job.yaml
```
