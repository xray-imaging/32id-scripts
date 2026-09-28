#!/bin/bash
# Open ImageJ with the EPICS areaDetector viewer plugins, to watch the 32-ID-C
# Kinetix camera live.
#
# Unlike the IOC wrappers in this directory, this does NOT ssh anywhere.  Both
# 2-BM and 19-BM launch ImageJ the same way: it is a GUI and belongs on the
# machine the operator is sitting at, and ~/Software is on the shared home so
# it is visible from all of them.
#
# WHERE YOU RUN THIS DECIDES WHERE THE IMAGES TRAVEL.  One full Kinetix frame is
# 3200 x 3200 x 2 = 20.48 MB.  Normal use is from txmthree, which means frames
# cross the network from maxwell -- that is the intended arrangement.  Running
# it on maxwell instead keeps the stream local to the machine holding the
# camera, which is worth knowing if bandwidth ever becomes the limit; note the
# sustained write path to /data2 already runs at about 1130 MB/s during a scan.
#
# USE THE NTNDA VIEWER.  A full frame will not fit through Channel Access here.
#     Plugins -> EPICS areaDetector -> EPICS NTNDA Viewer
#     channel:  32idK1:Pva1:Image
# Verified 2026-09-27: that channel is an epics:nt/NTNDArray:1.0 served from
# maxwell and resolves from txmthree once the PVA address list below names
# maxwell explicitly.

IJ_HOME=/home/beams/USERTXM/Software/ImageJ
LOG=/tmp/imagej-$(id -un).log

# --- checks ----------------------------------------------------------------
[ -n "$DISPLAY" ] || { echo "No DISPLAY: ImageJ is a GUI. Use a desktop session or ssh -X." >&2; exit 1; }
[ -x "$IJ_HOME/ImageJ" ] || { echo "ImageJ not found at $IJ_HOME" >&2; exit 1; }
# Match the process NAME, not the command line.  19-BM greps for "ij.ImageJ",
# which finds nothing here: this launcher is a native binary that execs the JVM
# and keeps its own argv, so the process shows up as comm "ImageJ", cmd
# "./ImageJ".  A -f search on "ij.ImageJ" also risks matching the very shell
# running the check.
pgrep -x ImageJ >/dev/null && { echo "ImageJ is already running on $(hostname -s)."; exit 0; }

# --- EPICS environment -----------------------------------------------------
# Set only what the caller has not.  A MEDM shell command inherits the
# environment of whatever started MEDM; start_tomo exports a CA list but not a
# PVA one, and 2-BM's equivalent button sets neither -- which is why it works
# there only by accident of the shell MEDM happened to start from.
#
# txmthree is on the public 32-ID subnet and every IOC is on the private one,
# so a broadcast reaches nothing and the hosts must be named by unicast.
# Without EPICS_PVA_ADDR_LIST, "pvinfo 32idK1:Pva1:Image" times out from here;
# with maxwell named it resolves immediately.  Names, not addresses: both
# lists resolve at startup, which keeps the numbering out of a public repo.
: "${EPICS_CA_ADDR_LIST:=164.54.102.255 s32pvgate gauss txm4 maxwell ioc32idc01 ioc32idc02}"
: "${EPICS_PVA_ADDR_LIST:=maxwell}"
: "${EPICS_PVA_AUTO_ADDR_LIST:=NO}"

# The CA viewer needs a ceiling above one frame.  Raising it here does not by
# itself make Channel Access work at full resolution -- the IOC has its own
# limit and the smaller of the two wins -- it only stops the client being what
# refuses.  Use the NTNDA viewer instead; pvAccess has no such limit.
: "${EPICS_CA_MAX_ARRAY_BYTES:=160000000}"

export EPICS_CA_ADDR_LIST EPICS_PVA_ADDR_LIST EPICS_PVA_AUTO_ADDR_LIST
export EPICS_CA_MAX_ARRAY_BYTES

# --- launch ----------------------------------------------------------------
# ImageJ.cfg names "." as its working directory and carries the heap ceiling
# (-Xmx), so that setting lives there, not here.
cd "$IJ_HOME" || exit 1
./ImageJ >"$LOG" 2>&1 &
echo "ImageJ started on $(hostname -s)  (log: $LOG)"
