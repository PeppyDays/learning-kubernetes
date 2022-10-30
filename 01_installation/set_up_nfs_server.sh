# create nfs directory and set exports
mkdir -p /mnt/share
chown -R nobody:nogroup /mnt/share
chmod 777 /mnt/share
echo "/mnt/share $1.0/24(rw,sync,no_subtree_check)" >> /etc/exports
exportfs -a
systemctl restart nfs-kernel-server
