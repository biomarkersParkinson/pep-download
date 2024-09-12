#!/bin/bash

# Set job requirements
#SBATCH -p genoa
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 10:00:00

# Slurm batch job that downloads one column of data.
# The column should be available in the environment variable COLUMN

DATADIR="/projects/0/einf2658/PPP"
OUTPUTDIR="$DATADIR/partial/$COLUMN"

if [ -d "$OUTPUTDIR/output" ] # If output directory is present, data was already downloaded before
then
    # Resume download
    echo "Resuming download of $COLUMN"

    # Execute pepcli in Singularity container
    # and move data to DATADIR if successful
    singularity exec \
      -B "$HOME/pep-token":/token:ro \
      -B "$OUTPUTDIR":/data \
      --contain \
      --no-mount hostfs \
      "$HOME/pep-client.sif" \
      /app/pepcli --client-working-directory /config --oauth-token /token/OAuthToken.json pull --update --resume -o /data/output/$COLUMN && \
    mv $OUTPUTDIR/output/$COLUMN $DATADIR && rm -rf $OUTPUTDIR
else
    # Start new download
    echo "Starting download of $COLUMN"

    # Execute pepcli in Singularity container
    # and move data to DATADIR if successful
    singularity exec \
      -B "$HOME/pep-token":/token:ro \
      -B "$OUTPUTDIR":/data \
      --contain \
      --no-mount hostfs \
      "$HOME/pep-client.sif" \
      /app/pepcli --client-working-directory /config --oauth-token /token/OAuthToken.json pull -c $COLUMN -P psp-controls -o /data/output/$COLUMN && \
    mv $OUTPUTDIR/output/$COLUMN $DATADIR && rm -rf $OUTPUTDIR
fi
