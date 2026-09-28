#!/bin/bash

# Start the 32-ID mctOptics IOC (32id:MCTOptics:).#
# NOTE the boot directory: ioc32IDMCTOptics is the 32-ID configuration
# (P=32id:, R=MCTOptics:, TOMOSCAN=32idc:TomoScan:, cameras 32idK1:).  The
# sibling iocMCTOptics is still the 2-BM configuration -- its substitutions
# carry 2bm: prefixes throughout -- so starting that one gives an mctOptics
# that talks to no hardware here.  ~/scripts/start_op.sh currently points at
# that 2-BM directory.
#
# start_IOC runs "mctOpticsApp st.cmd" in the FOREGROUND, so the IOC lives in
# this window.  The IOC does not need the conda environment; the server does.

# Define variables
TAB_NAME="mctOptics IOC"
REMOTE_USER="usertxm"
REMOTE_HOST="maxwell"
APP_NAME="mctOpticsApp"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/mctoptics/iocBoot/ioc32IDMCTOptics/"

BODY="~/scripts/kill_IOC.sh ${APP_NAME}; cd ${WORK_DIR} && ./start_IOC"

# ssh runs its remote command in the user's LOGIN shell.  For usertxm on maxwell
# that is /bin/tcsh, where "." is not a source builtin: the body fails with
# "/bin/.: Permission denied", conda is never defined, and python -i then runs
# the system interpreter and dies with "No module named 'tomoscan'".  Wrapping
# in "bash -lc" fixes it.  The 19-BM scripts do not need this because factuser's
# login shell is already bash -- that difference is the whole reason this line
# looks different from theirs.
#
# BODY must stay on ONE line: tcsh does not reliably carry a multi-line quoted
# argument through, and it must contain no single quotes.
if [ "$(hostname -s)" = "$REMOTE_HOST" ]; then
    CMD="bash -lc '$BODY'"
else
    CMD="ssh -t ${REMOTE_USER}@${REMOTE_HOST} \"bash -lc '$BODY'\""
fi

# gnome-terminal is a D-Bus client: it asks the session bus to activate
# gnome-terminal-server.  Over a forwarded X display -- MEDM started from
# txmthree with DISPLAY=localhost:NN -- that activation fails with "Could not
# activate remote peer" and nothing opens.  It cannot be detected by exit
# status: gnome-terminal returns 0 even when the activation failed.  Ask the
# session bus directly whether the terminal factory answers, and fall back to
# xterm, which draws its own window and needs no D-Bus.  Same arrangement as
# the 19-BM scripts.
if gdbus call --session --dest org.gnome.Terminal \
        --object-path /org/gnome/Terminal/Factory0 \
        --method org.freedesktop.DBus.Peer.Ping >/dev/null 2>&1; then
    gnome-terminal --tab --title="$TAB_NAME" -- bash -c "$CMD"
else
    xterm -hold -title "$TAB_NAME" -e bash -c "$CMD" &
fi
