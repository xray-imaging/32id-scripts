#!/bin/bash

# Define variables
TAB_NAME="ADetector IOC Kinetix"
REMOTE_USER="usertxm"
REMOTE_HOST="maxwell"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/ADKinetix/iocs/kinetixIOC/iocBoot/iocKinetix/softioc"

# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        cd ${WORK_DIR}
        ./32idKinetix.pl stop
        sleep 2
        ./32idKinetix.pl run
    ';
"

