# remove ubuntu-jammy entry
sed -e '/^.*ubuntu-jammy.*/d' -i /etc/hosts

# set local dns
echo "$2.10 kube-master" >> /etc/hosts
for ((i=1; i<=$1; i++)); do echo "$2.10$i kube-worker-0$i" >> /etc/hosts; done

# set dns
sed -i -e 's/#DNS=/DNS=8.8.8.8/' /etc/systemd/resolved.conf
service systemd-resolved restart

# disable swap
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# load kernel modules
tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF
modprobe overlay
modprobe br_netfilter

# set kernel parameters
tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# reload kernel changes
sysctl --system
