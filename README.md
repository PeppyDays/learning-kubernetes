# Learning Kubernetes

## Installation

In the `installation` directory, `vagrant up` will boost a kubernetes cluster (v1.24.6) including 1 master and 2 workers automatically using virtualbox. You can customize component versions, resources, the number of workers and CIDR in `Vagrantfile`.

Vagrant, VirtualBox must be pre-installed.

```bash
cd installation
vagrant up
```
