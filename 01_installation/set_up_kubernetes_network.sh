# set kubeconfig path for kubectl
export KUBECONFIG=/etc/kubernetes/admin.conf

# install calico
# https://projectcalico.docs.tigera.io/getting-started/kubernetes/self-managed-onprem/onpremises
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v$1/manifests/calico.yaml

# # install metallb
# # https://metallb.universe.tf/installation/
# kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v$2/config/manifests/metallb-native.yaml
# cat > /tmp/metallb_config.yaml <<EOF
# apiVersion: metallb.io/v1beta1
# kind: IPAddressPool
# metadata:
#   name: ip-address-pool
#   namespace: metallb-system
# spec:
#   addresses:
#   - $3.200-$3.253
#   avoidBuggyIPs: true
# ---
# apiVersion: metallb.io/v1beta1
# kind: L2Advertisement
# metadata:
#   name: l2-advertisement
#   namespace: metallb-system
# spec:
#   ipAddressPools:
#   - ip-address-pool
# EOF
# kubectl apply -f /tmp/metallb_config.yaml

# # install nginx ingress controller
# # https://kubernetes.github.io/ingress-nginx/deploy/#bare-metal
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.4.0/deploy/static/provider/cloud/deploy.yaml
