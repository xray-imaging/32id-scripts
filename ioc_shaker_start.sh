#!/bin/bash

# --- Configuration ---
BASE_DIR="/net/s32dserv/xorApps/epics/synApps_6_3/ioc"
GNOME_TERMINAL="dbus-launch gnome-terminal"

# IOC list: "IOC_NAME SCRIPT_PATH"
declare -a IOC_LIST=(
    "32IDBSHAKER ${BASE_DIR}/32idbShaker/iocBoot/ioc32idbShaker/softioc/32idbShaker.pl"
)

for entry in "${IOC_LIST[@]}"; do
    read IOC_NAME SCRIPT_PATH <<< "$entry"

    echo "Checking $IOC_NAME..."

    STATUS_OUTPUT=$("$SCRIPT_PATH" status 2>&1 || echo "__STATUS_FAILED__")

    if echo "$STATUS_OUTPUT" | grep -qE "is running"; then
        echo "$IOC_NAME is already running. Skipping."
    else
        echo "$IOC_NAME is NOT running. Launching in gnome-terminal tab..."

        $GNOME_TERMINAL --tab --title="$IOC_NAME" -- bash -c "
            source ~/.bashrc
            echo 'Starting $IOC_NAME...'
            $SCRIPT_PATH start
            $SCRIPT_PATH medm
            exec bash
        "
    fi
done

