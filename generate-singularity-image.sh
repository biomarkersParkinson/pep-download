
docker run \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /Users/peter/repos/dbpd/pep-download/output:/output \
  --privileged -t --rm \
  quay.io/singularity/docker2singularity \
  gitlabregistry.pep.cs.ru.nl/pep-public/core/ppp-prod:latest
