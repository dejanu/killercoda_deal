
### Inspect Docker Ubuntu


```bash
# check the file for dockerd service unit, what's the main command/process that systemd will manage as a service
grep -i exec /lib/systemd/system/docker.service 

# check the full path of the command/process dockerd/containerd/containerd-shim
ps -fC dockerd

# get dockerd/containerd/containerd-shim process PID: pidof dockerd/containerd/containerd-shim
# not efficent: ps auxfww | grep docker | grep -v grep 
ps -C dockerd -o pid,ppid,cmd --forest
ps -C containerd -o pid,ppid,cmd --forest

# start containers
docker run --rm -d nginx
docker run --rm -d alpine sleep 3600

# check containerd-shim per container
ps -C containerd-shim -o pid,ppid,cmd --forest

# check process inside the container
pstree -p 2269
pstree -p 1895

# dockerd listens on /run/docker.sock: socket and uses another socket /run/containerd/containerd.sock to talk with containerd
docker system info --format "Ruleaza: {{.Runtimes}} cu default {{.DefaultRuntime}}
```