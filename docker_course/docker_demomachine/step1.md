
### Inspect Docker Ubuntu


```bash
# check the file for dockerd service unit, what's the main command/process that systemd will manage as a service
grep -i exec /lib/systemd/system/docker.service 

# check the full path of the command/process dockerd
ps -fC dockerd

# get dockerd process PID: pidof dockerd
ps auxfww | grep docker | grep -v grep # not efficent
ps -C dockerd -o pid,ppid,cmd --forest
ps -fC dockerd 

# dockerd listens on /run/docker.sock: socket and uses another socket /run/containerd/containerd.sock to talk with containerd
docker system info --format "Ruleaza: {{.Runtimes}} cu default {{.DefaultRuntime}}
```