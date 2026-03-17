#!/bin/bash

# --- Configuration ---
REMOTE_USER="usertxm"
REMOTE_HOST="txm4"
BASE_DIR="/net/s32dserv/xorApps/epics/synApps_6_3/ioc"
GNOME_TERMINAL="dbus-launch gnome-terminal"

# IOC list: "IOC_NAME APP_NAME WORK_DIR SCRIPT_PATH"
declare -a IOC_LIST=(
    "32IDASOFT 32idaSoftApp ${BASE_DIR}/32idaSoft/iocBoot/ioc32idaSoft/softioc 32idaSoft.pl"
    "32IDBSOFT 32idbSoftApp ${BASE_DIR}/32idbSoft/iocBoot/ioc32idbSoft/softioc 32idbSoft.pl"
    "32IDCSOFT 32idcSoftApp ${BASE_DIR}/32idcSoft/iocBoot/ioc32idcSoft/softioc 32idcSoft.pl"
)

for entry in "${IOC_LIST[@]}"; do
    read IOC_NAME APP_NAME WORK_DIR SCRIPT_PATH <<< "$entry"

    echo "Checking $IOC_NAME..."

    STATUS=$(cd "${WORK_DIR}" && source ~/.bashrc && ./${SCRIPT_PATH} status 2>&1 || echo "__STATUS_FAILED__")

    if echo "$STATUS" | grep -q "is running"; then
        echo "$IOC_NAME is already running. Skipping."
    else
        echo "$IOC_NAME is NOT running. Launching in gnome-terminal tab..."

        $GNOME_TERMINAL --tab --title="$IOC_NAME" -- bash -c "
            # ssh -t ${REMOTE_USER}@${REMOTE_HOST} '
            	source ~/.bashrc
            	cd '${WORK_DIR}' || exit 1
		echo 'Starting $IOC_NAME...'
		./${SCRIPT_PATH} stop
		exec bash
        "
    fi
done
