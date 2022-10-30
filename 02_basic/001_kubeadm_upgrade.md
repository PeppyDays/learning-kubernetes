# Kubernetes Upgrade

```bash
# drain nodes if control plane has pods
$ k drain kube-master --ignore-daemonsets

# search all installable package versions
$ sudo apt list kubeadm -a

    Listing... Done
    kubeadm/kubernetes-xenial 1.25.3-00 amd64 [upgradable from: 1.24.6-00]
    kubeadm/kubernetes-xenial 1.25.2-00 amd64
    ..
    kubeadm/kubernetes-xenial,now 1.24.6-00 amd64 [installed,upgradable to: 1.25.3-00]
    ..

# install kubeadm and kubelet on kube-master node
$ sudo apt install kubeadm=1.25.3-00 kubelet=1.25.3-00

# upgrade kubeadm
$ sudo apt upgrade plan
$ sudo apt upgrade apply v1.25.3

# restart kubelet, if needed
$ sudo systemctl restart kubelet

# uncordon control plane
$ k uncordon kube-master

# check node status
$ k get no

    NAME             STATUS                     ROLES           AGE   VERSION
    kube-master      Ready,SchedulingDisabled   control-plane   34m   v1.25.3
    kube-worker-01   Ready                      <none>          32m   v1.24.6
    kube-worker-02   Ready                      <none>          30m   v1.24.6

# install kubelet and restart kubelet on worker nodes
$ sudo apt install -y kubelet=1.25.3-00 --allow-change-held-packages
```
