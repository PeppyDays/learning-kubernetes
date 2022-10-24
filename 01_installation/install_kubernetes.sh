# enable docker registry
# https://docs.docker.com/engine/install/ubuntu/
apt-get -y install ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# install containerd
apt update
apt install -q -y containerd.io=$1-1

# configure containerd for using systemd as cgroup
containerd config default | tee /etc/containerd/config.toml > /dev/null 2>&1
sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

# restart and enable containerd
systemctl restart containerd
systemctl enable containerd

# enable kubernetes registry
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
apt-get install -y apt-transport-https ca-certificates curl
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

apt-get update
apt-get install -q -y kubelet=$2-00 kubeadm=$2-00 kubectl=$2-00
apt-mark hold kubelet kubeadm kubectl
