# set kubeconfig path for kubectl
export KUBECONFIG=/etc/kubernetes/admin.conf

# clone nfs subdir external provision
# https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner
mkdir -p /tmp/nfs-subdir-external-provision
cd /tmp/nfs-subdir-external-provision
git clone https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner.git .

# create namespace
kubectl create namespace nfs-provisioner

# modify configuration
sed -i'' "s/namespace:.*/namespace: nfs-provisioner/g" ./deploy/rbac.yaml ./deploy/deployment.yaml
sed -i'' "s/10.3.243.101/$1.10/g" ./deploy/deployment.yaml
sed -i'' "s/\/ifs\/kubernetes/\/mnt\/share/g" ./deploy/deployment.yaml

# deploy
kubectl apply -f ./deploy/rbac.yaml
kubectl apply -f ./deploy/deployment.yaml
kubectl apply -f ./deploy/class.yaml
