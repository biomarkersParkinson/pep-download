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
    FINISHED_DIR="$DATADIR/$c"
    PARTIAL_DIR="$DATADIR/partial/$c"
    JOB_ID_PATH="$PARTIAL_DIR/jobid"

    # Check if column not already completely downloaded
    if [ ! -d "$FINISHED_DIR" ]
    then
        echo "Checking $c"

        # Check if this is a new download
        if [ ! -d "$PARTIAL_DIR" ]
        then
            echo "Starting new download"
            mkdir $PARTIAL_DIR

            # This queues a new download job, extracts the job id from the output and writes that to a file
            RESULT=$(sbatch --export=COLUMN="$c" download_column.sh) && \
                echo $RESULT && \
                echo ${RESULT##* } > "$JOB_ID_PATH"

            ((N_JOBS--))
        else
            # This column was already partially downloaded

            # If download is curently running, don't create a new job for it
            # (It tries to show jobinfo for the job id which we know was running the download for this column)
            if ! scontrol show jobid -dd $(< "$JOB_ID_PATH") > /dev/null; then

                echo "Resuming download"

                # This queues a new download job, extracts the job id from the output and writes that to a file
                RESULT=$(sbatch --export=COLUMN="$c" download_column.sh) && \
                    echo $RESULT && \
                    echo ${RESULT##* } > "$JOB_ID_PATH"

                ((N_JOBS--))
            else
                echo "Download already in progress"
            fi
        fi
    fi

done <columns.txt

echo "Done"
