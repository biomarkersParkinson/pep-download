
singularity exec \
  -B "$HOME/pep-token":/token:ro \
  -B "$HOME/pep-output":/output \
  --pwd /output \
  "$HOME/pep-client.sif" \
  /app/pepcli --client-working-directory /config --oauth-token /token/OAuthToken.json query column-access > columns.txt


# # Open a bash shell in the container
# docker run \
#   --volume data:/output \
#   --volume /Users/$(whoami)/pepclient/secrets:/token:ro \
#   -it gitlabregistry.pep.cs.ru.nl/pep-public/core/ppp-prod:latest bash

# Example command to run inside:
# /app/pepcli --client-working-directory /config --oauth-token /token/OAuthToken.json query column-access > columns.txt
