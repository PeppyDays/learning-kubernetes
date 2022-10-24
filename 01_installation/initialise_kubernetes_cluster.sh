# initialise cluster
kubeadm init --pod-network-cidr $2.0.0/16 --apiserver-advertise-address $3.10 --token ykgti6.lq1ohpjhqhlddq9g --token-ttl 0

# set kube config for user vagrant
mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

# set kube config environment variable for use root temporarily
export KUBECONFIG=/etc/kubernetes/admin.conf

# install calico
# https://projectcalico.docs.tigera.io/getting-started/kubernetes/self-managed-onprem/onpremises
curl https://raw.githubusercontent.com/projectcalico/calico/v$1/manifests/calico.yaml -o /tmp/calico.yaml
sed -i -e 's/# - name: CALICO_IPV4POOL_CIDR/- name: CALICO_IPV4POOL_CIDR/' /tmp/calico.yaml
sed -i -e "s/#   value: \"192.168.0.0\/16\"/  value: \"$2.0.0\/16\"/" /tmp/calico.yaml
kubectl apply -f /tmp/calico.yaml

# set kubectl-friendly environments for user vagrant
# https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-bash-linux/
kubectl completion bash | tee /etc/bash_completion.d/kubectl > /dev/null
echo 'alias k=kubectl' >> /home/vagrant/.bashrc
echo "alias ka='kubectl apply -f'" >> /home/vagrant/.bashrc
echo 'complete -F __start_kubectl k' >> /home/vagrant/.bashrc
