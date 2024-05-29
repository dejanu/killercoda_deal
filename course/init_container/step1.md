
### Init Container

* Given that containers within the same pod can easily exchange data using a shared local filesystem or the localhost network interface coupled with the fact that containers are designed to run only a single process per container (unless the process itself spawns child processes), led to the emergence of a couple design patterns of which being **init-containers**.

* **init-containers** run before the application container thus enabling the separation of concerns, and providing a separate lifecycle for initialization-related tasks distinct from the main application containers.