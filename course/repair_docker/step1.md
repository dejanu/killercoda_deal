### Setup

Docker engine ubuntu setup:

![Scan results](./assets/docker_ubuntu.png)


* Check the status: 

Run command: `docker ps`{{exec}}, check the state of docker service using `systemctl` to query systemd journal: `journalctl  -xeu docker.service`{{exec}}.

<details>
<summary>Solution1</summary>
Check the status of <code>docker.socket</code> and use systemctl to start the unit <code>systemctl start docker.socket </code> 
</details>

Check images on the machine `docker image ls` start a container based on `dejanualex/dockersay:2.0` image, next user `curl` and leverage unix domain socket to list images.

<details>
<summary>Solution2</summary>
 **curl** can talk to a Unix Socket via the <code>--unix-socket</code> flag <code>curl --unix-socket /var/run/docker.sock http://localhost/images/json</code> 
</details>