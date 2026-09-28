#!/bin/bash

# Start the 32-ID-C Micro-CT tomoScan python server (TomoScan32IDC).
#
# NOT tomoscan_server.sh, which starts the TXM server on gauss.
#
# conda.sh is sourced explicitly because "conda activate" is a shell function
# defined by the init block in ~/.bashrc, which a non-interactive shell does not
# read.  tomoscan is not an editable install here: a change in the repo needs
# "pip install ." before this picks it up.

# Define variables
TAB_NAME="tomoScan 32IDC py server"
REMOTE_USER="usertxm"
REMOTE_HOST="maxwell"
CONDA_ENV="tomoscan"
CONDA_SH="/home/beams/USERTXM/conda/anaconda/etc/profile.d/conda.sh"
SCRIPT_NAME="start_tomoscan.py"
WORK_DIR="/home/beams/USERTXM/epics/synApps/support/tomoscan/iocBoot/iocTomoScan_32IDC/"

BODY="cd ${WORK_DIR} && . ${CONDA_SH} && conda activate ${CONDA_ENV} && ~/scripts/kill_server.sh ${SCRIPT_NAME}; python -i ${SCRIPT_NAME}"

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
