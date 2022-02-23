#!/bin/bash
gnome-terminal --tab --title "tomoScanStep IOC" -- bash -c "ssh -t usertxm@txmtwo \
'bash ~/scripts/kill_IOC.sh tomoScanApp;  \
bash ~/scripts/kill_server.sh start_tomoscan.py; \
cd /home/beams/USERTXM/epics/synApps/support/tomoscan/iocBoot/iocTomoScan_32ID_STEP/; \
./start_IOC;\
bash'" 

