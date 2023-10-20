# Toolkit

Toolkit container with various CLI tools for infrastructure and kubernetes

## Tools 

- Scaleway CLI `scw`
- Kubernetes CLI `kubectl`
- Kubernetes Helm `helm`
- Kubernetes Krew `kubectl krew`
- Kubernetes Backup Script `kubernetes-backup-all` (Only backup resources, not PVC/PV data)
- MinIO CLI `mcli`
- Restic CLI `restic`
- Bind tools `dig`, `host`, etc.
- Rsync `rsync`
 
Some kubectl plugins are also installed by default, as they are used for `kubernetes-backup-all` :
- `neat`
- `slice`

## How to use this container

For Scaleway CLI :
```
docker run -it \
    -v ~/.config/scw/config.yaml:/root/.config/scw/config.yaml \
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