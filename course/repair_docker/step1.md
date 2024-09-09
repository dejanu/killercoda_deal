### Setup

Docker engine ubuntu setup:

![Scan results](./assets/docker_ubuntu.png)


* Check the status: 

Run command: `docker ps`{{exec}}, check the state of docker service using `systemctl` to query systemd journal: `journalctl  -xeu docker.service`{{exec}}.


<details>
<summary>Solution</summary>
Check the status of <code>docker.socket</code> and use systemctl to start the unit <code>systemctl start docker.socket </code> 
</details>