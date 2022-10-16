# Learning Kubernetes

## Installation

In the `installation` directory, `vagrant up` will boost a kubernetes cluster (v1.24.6) automatically using virtualbox. You can customize component versions, resources, the number of workers and CIDR in `Vagrantfile`.

Vagrant, VirtualBox must be pre-installed.

```bash
cd installation
vagrant up
```

The default spec of the kubernetes cluster is following.

### Nodes

In default, a single master and two workers will be deployed.

The master is:

- Hostname: kube-master
- Node IP: 192.168.56.10
- SSH port from localhost: 60010
- OS: Ubuntu 22.04
- Resource: 2 CPU and 2G memory

The workers are:

- Hostname: kube-worker-01, kube-worker-02
- Node IP: 192.168.56.101, 192.168.56.102
- SSH port from localhost: 60101, 60102
- OS: Ubuntu 22.04
- Resource: 2 CPU and 2G memory

### Kubernetes Cluster

The cluster's components in default are:

- Kubernetes (kubeadm, kubelet, kubectl) 1.24.6
- Calico 3.24.1
- Containerd 1.6.8

The network configuration in default is:

- Pod network CIDR: 10.244.0.0/16
