
<br>

### WELL DONE !

* Docker: `Docker -> dockerd -> containerd -> runc`

```bash
# locate command for docker CLI
file $(which docker)

# docker engine installed via package manage
apt list --installed  | grep docker

# list systemd services which running and look for docker service
systemctl list-units --type=service --state=running | grep docker

# docker service is actually dockerd (daemon process)
systemctl status docker.service

# Query the systemd journal
journalctl -xeu docker.service

# Check the file for dockerd service unit, i.e. the main command/process that systemd will manage as a service
grep -i exec /lib/systemd/system/docker.service 

# check the full path of the command/process dockerd
ps -fC dockerd

# get dockerd process PID
ps auxfww | grep docker 
ps -C dockerd # pidoff dockerd

# list files opened by dockerd process
lsof -p 

# dockerd listens on /run/docker.sock: socket and uses another socket /run/containerd/containerd.sock to talk with containerd
docker system info --format "Ruleaza: {{.Runtimes}} cu default {{.DefaultRuntime}}
```

