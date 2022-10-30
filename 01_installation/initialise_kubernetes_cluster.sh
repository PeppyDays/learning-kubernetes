# initialise cluster
kubeadm init --pod-network-cidr $1.0.0/16 --apiserver-advertise-address $2.10 --token ykgti6.lq1ohpjhqhlddq9g --token-ttl 0

# set kube config for user vagrant
mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

# set kubectl-friendly environments for user vagrant
# https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-bash-linux/
kubectl completion bash | tee /etc/bash_completion.d/kubectl > /dev/null
echo 'alias k=kubectl' >> /home/vagrant/.bashrc
echo "alias ka='kubectl apply -f'" >> /home/vagrant/.bashrc
echo 'complete -F __start_kubectl k' >> /home/vagrant/.bashrc
