gnome-terminal --tab --title "tomoScanStream IOC" -- bash -c "ssh -t usertxm@txmtwo \
'bash ~/scripts/kill_IOC.sh tomoScanApp;  \
bash ~/scripts/kill_server.sh start_tomoscan.py; \
cd /home/beams/USERTXM/epics/synApps/support/tomoscan/iocBoot/iocTomoScanStream_32ID/; \
./start_IOC;\
bash'" 

