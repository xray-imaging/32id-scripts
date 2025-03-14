#!/bin/bash

# Define variables
TAB_NAME="tomoStream py server"
REMOTE_USER="usertxm"
REMOTE_HOST="txmthree"
CONDA_ENV="tomostream"
SCRIPT_NAME="start_tomostream.py"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/tomostream/iocBoot/iocTomoStream_32ID/"

# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        cd ${WORK_DIR}
        conda activate ${CONDA_ENV}
        kill_server.sh ${SCRIPT_NAME}
        python -i ${SCRIPT_NAME}
    ';
"

