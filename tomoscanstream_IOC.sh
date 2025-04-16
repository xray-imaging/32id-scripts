#!/bin/bash

# Define variables
TAB_NAME="tomoScanStream IOC"
REMOTE_USER="usertxm"
REMOTE_HOST="gauss"
APP_NAME="tomoScanApp"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/tomoscan/iocBoot/iocTomoScanStream_32ID/"

# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        kill_IOC.sh ${APP_NAME}
        cd ${WORK_DIR}
        ./start_IOC;
    ';
"

