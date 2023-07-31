#!/bin/bash

# Automatically queues a number of download jobs. Run this script periodically, e.g. with cron.

# Determine how many jobs are currently running, and how many to start
# (Just count the lines in the queue)
N_JOBS=$(( 11 - $(squeue | wc -l) ))

echo "=================================================="
echo $(date)
echo "Starting $N_JOBS jobs"

DATADIR="/projects/0/einf2658/PPP"

# Read selected columns from file
while read c && [ $N_JOBS -gt 0 ]; do
    JOB_ID_PATH="$DATADIR/$c/jobid"

    #echo "Checking $c"

    # Check if this is a new download
    if [ ! -f "$JOB_ID_PATH" ] && [ ! -f "${JOB_ID_PATH}_finished" ]
    then
        echo "Queueing update job for $c"

        # This queues a new download job, extracts the job id from the output and writes that to a file
        RESULT=$(sbatch --export=COLUMN="$c" update_column.sh) && \
            echo $RESULT && \
            echo ${RESULT##* } > "$JOB_ID_PATH"

        ((N_JOBS--))
    fi

done < columns.txt

echo "Done"
