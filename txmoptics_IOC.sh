gnome-terminal --tab --title "txmOptics IOC" -- bash -c "ssh -t usertxm@txm4 \
'bash ~/scripts/kill_IOC.sh txmOpticsApp;  \
bash ~/scripts/kill_server.sh start_txmoptics.py; \
cd /home/beams/USERTXM/epics/synApps/support/txmoptics/iocBoot/iocTXMOptics/; \
./start_IOC;\
bash'" 

