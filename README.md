[![Docker Repository on Quay](https://quay.io/repository/bgruening/cellxgene/status "Docker Repository on Quay")](https://quay.io/repository/bgruening/cellxgene)

# docker-cellxgene

Docker image with [CELLxGENE](https://cellxgene.cziscience.com/) version 1.3.0.
This version is optimized for cellxgene usage in galaxy.

To build this container you can use the following command:

```bash
docker build -t CONTAINER_NAME .
docker run --rm -it -p 5005:5005 -v PATH/TO/DATA/CONTAINING/DIRECTORY:/data CONTAINER_NAME launch /data/FILE.h5ad --host 0.0.0.0 --port 5005
```

The container is stored on Quay.io and you can get it via:

```bash
docker pull quay.io/bgruening/cellxgene:1.0.0
```