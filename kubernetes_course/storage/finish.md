
<br>

### WELL DONE !

* Opaque are the default (general key-value) secrets but Kubernetes has other secret [types](https://kubernetes.io/docs/concepts/configuration/secret/#secret-types). For HTTP certs we have TLS `kubernetes.io/tls`, or to store registry credentials for pulling private image we have `kubernetes.io/dockerconfigjson `

* Secrets as Env Vars (Credentials, API keys) so small secrets and as Volume Mounts (Certificates, Config files,)