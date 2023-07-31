#!/bin/bash

# Open a bash shell in the container
docker run \
  --volume /Users/$(whoami)/pepclient/output:/output \
  --volume /Users/$(whoami)/pepclient/secrets:/token:ro \
  -it gitlabregistry.pep.cs.ru.nl/pep-public/core/ppp-prod:latest bash

# Example command to run inside:
# /app/pepcli --client-working-directory /config --oauth-token /token/OAuthToken.json query column-access > columns.txt

# Download list of all data (columns & participants)
# /app/pepcli --client-working-directory /config --oauth-token /token/OAuthToken.json list -C Chrhypadis -P all-ppp -l -g --no-inline-data > list-data.json
