#!/bin/bash

# Define variables
TAB_NAME="energy IOC"
REMOTE_USER="usertxm"
REMOTE_HOST="txm4"
APP_NAME="energyApp"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/energy/iocBoot/iocEnergy_32ID/"

# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    # ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        kill_IOC.sh ${APP_NAME}
	cd ${WORK_DIR}
        ./start_IOC;
    # ';
"
