#!/bin/bash

# Define variables
TAB_NAME="ADetector IOC"
REMOTE_USER="usertxm"
REMOTE_HOST="gauss"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/32idbSP1/iocBoot/ioc32idbSP1/softioc/"

# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        cd ${WORK_DIR}
        ./32idbSP1.sh stop
    ';
"

