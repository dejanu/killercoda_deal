## Setup

`kubelet` is the node agent that runs on each node and comunicates with the container runtime --> The `kubelet` takes a set of PodSpecs that are provided through various mechanisms (primarily through the apiserver) and ensures that the containers described in those PodSpecs are running and healthy.