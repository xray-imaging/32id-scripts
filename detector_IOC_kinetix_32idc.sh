#!/bin/bash

# Restart the 32-ID-C Micro-CT Kinetix detector IOC.
#
# A micro-CT copy of detector_IOC_kinetix.sh, which is left untouched because
# ~/scripts/iocs_start.adl still uses it.
#
# ".pl run" keeps the IOC in the FOREGROUND of this window so its console is
# visible; closing the window stops the IOC.  Use ".pl start" instead to detach
# it in a screen session, with the console going to softioc/logs/iocConsole/.
# This is the same trade-off the 19-BM detector script documents.

# Define variables
TAB_NAME="ADetector IOC Kinetix"
REMOTE_USER="usertxm"
REMOTE_HOST="maxwell"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/ADKinetix/iocs/kinetixIOC/iocBoot/iocKinetix/softioc"

BODY="cd ${WORK_DIR} && ./32idKinetix.pl stop; sleep 2; ./32idKinetix.pl run"

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
