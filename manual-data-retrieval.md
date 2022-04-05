These are some examples for manual downloads (just for reference). It is assumed that you already have the PEP-services Singularity image ([instructions](get-pep.md)) and that you have the credentials set up ([see readme](README.md)).

Also see [the PEP cli documentation](https://gitlab.pep.cs.ru.nl/pep-public/user-docs/-/wikis/Using-pepcli) for using the pepcli command.

## Run an interactive shell in the pep-services Singularity container

```
singularity shell \
  -B ~/pepclient/config:/config:ro \
  -B ~/pepclient/secrets:/secrets:ro \
  -B ~/pepclient/working:/data \
  --pwd /data \
  pep-services.sif
```

Just for the record, the equivalent docker command is

```
docker run \
  --volume ~/pepclient/config:/config:ro \
  --volume ~/pepclient/secrets:/secrets:ro \
  --volume ~/pepclient/working:/data \
  -w /data \
  -it gitlabregistry.pep.cs.ru.nl/pep/core/prod/pep-services:latest bash
```

## Execute pepcli

Make sure you are in /data (it needs to be a writable directory?) and execute any pepcli command with /app/pepcli

```
/app/pepcli \
  --client-working-directory /config \
  --oauth-token /secrets/oauth.json \
  query column-access > columns.txt
```

The downloaded data will be in the directory that you mounted at /data.

## Execute pepcli without starting shell

```
singularity exec \
  -B ~/pepclient/config:/config:ro \
  -B ~/pepclient/secrets:/secrets:ro \
  -B ~/pepclient/working:/data \
  --pwd /data \
  pep-services.sif \
  /app/pepcli --client-working-directory /config --oauth-token /secrets/oauth.json query column-access > columns.txt
```
