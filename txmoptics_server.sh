#!/bin/bash

# Define variables
TAB_NAME="txmOptics py server"
REMOTE_USER="usertxm"
REMOTE_HOST="txm4"
CONDA_ENV="tomoscan"
SCRIPT_NAME="start_txmoptics.py"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/txmoptics/iocBoot/iocTXMOptics/"

# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        cd ${WORK_DIR}
        conda activate ${CONDA_ENV}
        kill_server.sh ${SCRIPT_NAME}
        python -i ${SCRIPT_NAME}
    ';
"

