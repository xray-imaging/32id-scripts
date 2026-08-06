#!/bin/bash

# Define variables
TAB_NAME="JenaNV200D IOC"
REMOTE_USER="usertxm"
REMOTE_HOST="txm4"
IOC_CMD="/net/s32dserv/xorApps/epics/synApps_6_3/ioc/JenaNV200D/iocBoot/iocJenaNV200D/softioc/JenaNV200D.pl"

gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        ${IOC_CMD} stop
        sleep 2
        ${IOC_CMD} start
    ';
"
