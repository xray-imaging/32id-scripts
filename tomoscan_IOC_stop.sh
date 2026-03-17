#!/bin/bash

# Define variables
TAB_NAME="tomoScan IOC"
REMOTE_USER="usertxm"
REMOTE_HOST="gauss"
APP_NAME="tomoScanApp"
SCRIPT_NAME="start_tomoscan.py"

# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        ~/scripts/kill_IOC.sh ${APP_NAME}
        ~/scripts/kill_server.sh ${SCRIPT_NAME}  
    ';
"

