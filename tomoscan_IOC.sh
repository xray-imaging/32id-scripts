#!/bin/bash
gnome-terminal --tab --title "tomoScan IOC" -- bash -c "ssh -t usertxm@txm4 \
'bash ~/scripts/kill_IOC.sh tomoScanApp;  \
bash ~/scripts/kill_server.sh start_tomoscan.py; \
cd /home/beams/USERTXM/epics/synApps/support/tomoscan/iocBoot/iocTomoScan_32ID/; \
./start_IOC;\
bash'" 

