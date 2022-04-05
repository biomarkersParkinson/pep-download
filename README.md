# pep-download

To download from PEP, take the following steps:

* Get the PEP-services Docker image and convert it to a Singularity image. Detailed instructions are [here](get-pep.md).
* Configure things (below).
* Run the script (below).

## Configure

### Prepare the directories containing config and credentials

You should have received credentials and configuration files from the PEP team.

On your host machine, create a directory structure e.g. under `~/pepclient`:
* Put the config files (ClientConfig.json, rootCA.cert and ShadowAdministration.pub) in a subdirectory named `config`.
* Put your OAuth token (JSON file) in a subdirectory named `secrets` and name it `oauth.json`.
* Create an empty subdirectory named `~/pepclient/working`.

### Make sure paths are correct

The `download_column.sh` expects the PEP client config and secrets to be at `$HOME/pepclient`, and the pep-services image to be at `$HOME/pep-services.sif`.

The `auto_download.sh` and `download_column.sh` scripts refer to a data directory to download the data to.

### Columns.txt

Make sure the names of the columns you want to download are in columns.txt. They will be downloaded in order with one job per column.

## Run the auto_download script

Run `auto_download.sh` periodically (e.g. with cron) to queue new download jobs.

## Manual downloads

If you really want to, here are some [manual download instructions](manual-data-retrieval.md).
