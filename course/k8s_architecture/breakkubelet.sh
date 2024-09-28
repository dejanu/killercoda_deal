# The unit file, source configuration file or drop-ins of kubelet.service changed on disk. 
# Run 'systemctl daemon-reload' to reload units.

sed -i 's|/usr/bin/kubelet|/usr/local/bin/kubelet|' /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
sed -i 's|ExecStart=/usr/bin/kubelet|ExecStart=/usr/local/bin/kubelet|' /lib/systemd/system/kubelet.service
systemctl daemon-reload
systemctl restart kubelet
