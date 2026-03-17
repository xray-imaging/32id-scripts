#!/bin/bash

# Define variables
TAB_NAME="txmOptics py server"
REMOTE_USER="usertxm"
REMOTE_HOST="32idcws"
SCRIPT_NAME="start_txmoptics.py"

# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
        kill_server.sh ${SCRIPT_NAME}
"

