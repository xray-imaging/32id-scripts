#!/bin/bash

# Define variables
TAB_NAME="tomoScan IOC"
REMOTE_USER="usertxm"
REMOTE_HOST="txmtwo"
SCRIPT_NAME="start_tomoscan.py"
APP_NAME="tomoScanApp"

# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        kill_IOC.sh ${APP_NAME}
        kill_server.sh ${SCRIPT_NAME}
    ';
"

