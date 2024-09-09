### Setup

Docker engine ubuntu setup:

![Scan results](./assets/docker_ubuntu.png)


* Check the status: 

Run command: `docker ps`{{exec}}, check the state of docker service using `systemctl` query systemd journal `journalctl  -xeu docker.service`{{exec}}.


<details>
<summary>Hints</summary>
<br>
Check the status of `docker.socket`
</details>