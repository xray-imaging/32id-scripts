#!/bin/bash

# Define variables
TAB_NAME="tomoScanStream py server"
REMOTE_USER="usertxm"
REMOTE_HOST="gauss"
SCRIPT_NAME="start_tomoscan.py"

# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        kill_server.sh ${SCRIPT_NAME}
    ';
"
