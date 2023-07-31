## Download the PEP cli docker image to a local machine

Detailed instructions can be found at the [pep wiki](https://gitlab.pep.cs.ru.nl/pep-public/user-docs/-/wikis/Using-pepcli-with-docker).

Pull the docker image:

```
docker pull gitlabregistry.pep.cs.ru.nl/pep-public/core/ppp-prod:latest
```

Note that you might need to logout from the registry if you logged in before (it is public now):

```
docker logout gitlabregistry.pep.cs.ru.nl
```

## Converting the PEP cli Docker image to a Singularity image

This can be done on any machine that runs Docker (Singularity is not required), using the [docker2singularity](https://github.com/singularityhub/docker2singularity) tool as follows:

```
docker run -v /var/run/docker.sock:/var/run/docker.sock \
  -v /local/target/path:/output \
  --privileged -t --rm \
  quay.io/singularity/docker2singularity \
  gitlabregistry.pep.cs.ru.nl/pep-public/core/ppp-prod:latest
```

This will generate a .sif file at the /local/target/path

## Upload the PEP cli image to HPC environment

Just use `scp` or any SFTP client.
