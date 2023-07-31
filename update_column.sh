#!/bin/bash

# Set job requirements
#SBATCH -p staging
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 10:00:00

# Slurm batch job that downloads one column of data.
# The column should be available in the environment variable COLUMN

DATADIR="/projects/0/einf2658/PPP"

echo "Updating data for $COLUMN"

singularity exec \
  -B "$HOME/pep-token":/token:ro \
  -B "$DATADIR":/data \
  --contain \
  --no-mount hostfs \
  "$HOME/pep-client.sif" \
  /app/pepcli --client-working-directory /config --oauth-token /token/OAuthToken.json pull -u -o /data/$COLUMN && \
  mv $DATADIR/$COLUMN/jobid $DATADIR/$COLUMN/jobid_finished
