
<br>

### Docker demo machine


* Docker: `Docker -> dockerd -> containerd -> runc`

```bash
# locate docker CLI
which docker
file /usr/bin/docker

# docker engine installed via package manager
apt list --installed  | grep docker

# look for docker service in systemd services 
systemctl list-units --type=service --state=running | grep docker

# docker service is actually dockerd (daemon process)
systemctl status docker.service

# query the systemd journal
journalctl -xeu docker.service

# Check the file for dockerd service unit, what's the main command/process that systemd will manage as a service
grep -i exec /lib/systemd/system/docker.service 

# check the full path of the command/process dockerd
ps -fC dockerd

# get dockerd process PID
ps auxfww | grep docker 
ps -C dockerd # pidoff dockerd

# dockerd listens on /run/docker.sock: socket and uses another socket /run/containerd/containerd.sock to talk with containerd
docker system info --format "Ruleaza: {{.Runtimes}} cu default {{.DefaultRuntime}}
```
