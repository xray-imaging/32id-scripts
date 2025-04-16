#!/bin/bash

# Define variables
TAB_NAME="txmOptics py server"
REMOTE_USER="usertxm"
REMOTE_HOST="txm4"
CONDA_ENV="tomoscan"
SCRIPT_NAME="start_txmoptics.py"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/txmoptics/iocBoot/iocTXMOptics/"
CONDA_PATH="/home/beams/USERTXM/conda/anaconda/"

# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
#gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
#        cd ${WORK_DIR}
#        pwd
#	conda activate ${CONDA_ENV} && \
#        kill_server.sh ${SCRIPT_NAME} && \
#        python -i ${SCRIPT_NAME}
#"

# Modified 24 March - AM. 
# Open a new tab in gnome-terminal, SSH into tomdet, activate conda, and run Python (without login shell)
gnome-terminal --tab --title="$TAB_NAME" -- bash -c "
        cd ${WORK_DIR}
        source ${CONDA_PATH}/etc/profile.d/conda.sh && \
        conda activate ${CONDA_ENV} && \
        kill_server.sh ${SCRIPT_NAME} && \
        python -i ${SCRIPT_NAME}
"
