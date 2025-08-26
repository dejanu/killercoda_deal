
<br>

### Docker demo machine


* Docker: `Docker -> dockerd -> containerd -> runc`


![Scan results](./assets/docker_shim.png

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

# get dockerd process PID: pidof dockerd
ps auxfww | grep docker | grep -v grep # not efficent
ps -C dockerd -o pid,ppid,cmd --forest
ps -fC dockerd 

# dockerd listens on /run/docker.sock: socket and uses another socket /run/containerd/containerd.sock to talk with containerd
docker system info --format "Ruleaza: {{.Runtimes}} cu default {{.DefaultRuntime}}
```


* Show containers are not real

* Show CMD vs ENTRYPOINT

* Build build build

Build from remote `docker build -t demo https://github.com/dejanu/sretoolkit.git#remotebuild:docker_stuff --no-cache`{{copy}}

* Docker create images from containers

Docker [commit container](https://docs.docker.com/reference/cli/docker/container/commit/): `docker run --name=baseimage -ti --entrypoint=/bin/sh python:3.9.22-alpine`{{copy}}

Create new image layers manually using the docker container commit

`docker container commit -m "Add script" baseimage newimage`{{copy}}
`docker run --entrypoint=/tmp/test newimage`{{copy}}

