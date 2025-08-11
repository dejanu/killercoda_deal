### Setup

Docker engine ubuntu setup:

![Scan results](./assets/docker_ubuntu.png)



* Try to use docker CLI `docker ps`{{exec}}, check the `dockerd` service is working alternatively check the state of docker service using `systemctl` (if needed query systemd journal: `journalctl  -xeu docker.service`{{exec}}). 

* Check images on the machine `docker image ls` start a container based on `dejanualex/dockersay:2.0` image, next use `curl` and leverage unix domain socket `--unix-socket` to **list images**: `curl --unix-socket /var/run/docker.sock http://localhost/images/json`{{copy}}

<hr>

<details>
<summary>Hint</summary>
Check the status of <code>docker.socket</code> and use systemctl to start the unit <code>systemctl start docker.socket</code> 
</details>

