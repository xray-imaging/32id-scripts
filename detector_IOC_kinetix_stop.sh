#!/bin/bash

# Stop the 32-ID-C Micro-CT Kinetix detector IOC.
#
# The older detector_IOC_stop_kinetix.sh does NOT stop anything -- it runs
# "./32idKinetix.pl run", which starts the IOC.  That file is still wired to the
# Stop button of ~/scripts/iocs_start.adl, so that button starts the IOC.  The
# fix there is one word, run -> stop; this script is separate so nothing
# depending on the old behaviour changes underneath it.
#
# "stop" kills by PID, so it works whether the IOC was started with run or start.

# Define variables
TAB_NAME="ADetector IOC Kinetix"
REMOTE_USER="usertxm"
REMOTE_HOST="maxwell"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/ADKinetix/iocs/kinetixIOC/iocBoot/iocKinetix/softioc"

BODY="cd ${WORK_DIR} && ./32idKinetix.pl stop"

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
