#!/bin/bash                                                                                                                
                                                                                                                           
# Define variables
TAB_NAME="tomoScanFPGA IOC"                                                                                                
REMOTE_USER="usertxm"
REMOTE_HOST="gauss"
CONDA_ENV="tomoscan"
APP_NAME="tomoScanApp"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/tomoscan/iocBoot/iocTomoScanFPGA_32ID/"

gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        ~/scripts/kill_IOC.sh ${APP_NAME}
        cd ${WORK_DIR}
        conda activate ${CONDA_ENV}
        ./start_IOC;
    ';
"
