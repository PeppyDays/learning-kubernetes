# set kubeconfig path for kubectl
export KUBECONFIG=/etc/kubernetes/admin.conf

# set metric api
# https://github.com/kubernetes-sigs/metrics-server
wget https://github.com/kubernetes-sigs/metrics-server/releases/download/v$1/components.yaml -O /tmp/metrics-server.yaml
sed -i '/--kubelet-preferred-address-types=.*/a \        - --kubelet-insecure-tls' /tmp/metrics-server.yaml
kubectl apply -f /tmp/metrics-server.yaml
