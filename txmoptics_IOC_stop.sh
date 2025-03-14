#!/bin/bash

# Define variables
TAB_NAME="txmOptics IOC"
REMOTE_USER="usertxm"
REMOTE_HOST="txm4"
SCRIPT_NAME="start_txmoptics.py"
APP_NAME="txmOpticsApp"

# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        kill_IOC.sh ${APP_NAME}
        kill_server.sh ${SCRIPT_NAME}
    ';
"

