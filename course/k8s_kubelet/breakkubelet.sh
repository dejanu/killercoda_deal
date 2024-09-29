# The unit file, source configuration file or drop-ins of kubelet.service changed on disk. 
# Run 'systemctl daemon-reload' to reload units.

# sed -i 's|/usr/bin/kubelet|/usr/local/bin/kubelet|' /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
# sed -i 's|ExecStart=/usr/bin/kubelet|ExecStart=/usr/local/bin/kubelet|' /lib/systemd/system/kubelet.service

ssh node01 "sudo sed -i 's|/usr/bin/kubelet|/usr/local/bin/kubelet|' /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf"
ssh node01 "systemctl daemon-reload"
# ssh node01 "systemctl stop kubelet"
# ssh node01 "systemctl start kubelet"
