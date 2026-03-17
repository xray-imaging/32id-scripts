#!/bin/bash

# Define variables
TAB_NAME="tomoScanFPGA py server"
REMOTE_USER="usertxm"
REMOTE_HOST="gauss"
CONDA_ENV="tomoscan"
SCRIPT_NAME="start_tomoscan.py"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/tomoscan/iocBoot/iocTomoScanFPGA_32ID/"
CONDA_PATH="/home/beams/USERTXM/conda/anaconda/"

gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
    ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
        bash -l -c \"cd ${WORK_DIR} && hostname &&\
        ~/scripts/kill_server.sh ${SCRIPT_NAME} && \
        source ${CONDA_PATH}/etc/profile.d/conda.sh && \
        conda activate ${CONDA_ENV} && \
        python -i ${SCRIPT_NAME}; \"
    '
"
