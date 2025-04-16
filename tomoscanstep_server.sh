#!/bin/bash

# Define variables
TAB_NAME="tomoScanStep py server"
REMOTE_USER="usertxm"
REMOTE_HOST="gauss"
CONDA_ENV="tomoscan"
SCRIPT_NAME="start_tomoscan.py"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/tomoscan/iocBoot/iocTomoScan_32ID_STEP/"

# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        cd ${WORK_DIR}
        conda activate ${CONDA_ENV}
        kill_server.sh ${SCRIPT_NAME}
        python -i ${SCRIPT_NAME}
    ';
"

