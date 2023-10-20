# container-scw-cli
Scaleway cli container with tools

## How to use this container

For Scaleway CLI :
```
docker run -it \
    -v path-to-config.yaml:/root/.config/scw/config.yaml \
    infrabuilder/scw-cli scw version
```

For Kubernetes :
```
docker run -it \
    -v ~/.kube/config:/root/.config/scw/config.yaml \
    infrabuilder/scw-cli kubectl get node
```

To backup Kubernetes cluster resources :
```
docker run -it \
    -v ~/.kube/config:/root/.config/scw/config.yaml \
    -v $PWD:/cli \
    infrabuilder/scw-cli kubernetes-backup-all
```