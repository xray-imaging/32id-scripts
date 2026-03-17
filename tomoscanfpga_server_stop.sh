#!/bin/bash

# Define variables
TAB_NAME="tomoScanFPGA py server"
REMOTE_USER="usertxm"
REMOTE_HOST="gauss"
SCRIPT_NAME="start_tomoscan.py"

gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        ~/scripts/kill_server.sh ${SCRIPT_NAME}
    ';
"
