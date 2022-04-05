## Download the PEP cli docker image to a local machine

Pull the docker image from the (secured) repository using the appropriate credentials:

```
docker login gitlabregistry.pep.cs.ru.nl
docker pull gitlabregistry.pep.cs.ru.nl/pep/core/prod/pep-services:latest
```

## Converting the PEP cli Docker image to a Singularity image

This can be done on any machine that runs Docker (Singularity is not required), using the [docker2singularity](https://github.com/singularityhub/docker2singularity) tool as follows:

```
docker run -v /var/run/docker.sock:/var/run/docker.sock \
  -v /local/target/path:/output \
  --privileged -t --rm \
  quay.io/singularity/docker2singularity \
  gitlabregistry.pep.cs.ru.nl/pep/core/prod/pep-services
```

This will generate pep-services.sif at the /local/target/path


## Upload the PEP cli image to HPC environment

Just use `scp` or any SFTP client.
