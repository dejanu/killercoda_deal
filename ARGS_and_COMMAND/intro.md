
<br>

### Setup 

In this scenario we'll learn how to start a container in a pod, leveraging `command` and `args` field.

For this scenario we have our app `cowsay` containerized, available [here](https://hub.docker.com/repository/docker/dejanualex/dockersay/general).

Inside the pod we run `cowsay Hello World!` generating an ASCII art of a Docker whale with the message "Hello World!" written to STDOUT.

```bash
 ______________
< Hello World! >
 --------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```


