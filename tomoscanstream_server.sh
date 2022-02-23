gnome-terminal --tab --title "tomoScan py server" -- bash -c "ssh -t usertxm@txmtwo \
'bash ~/scripts/kill_server.sh start_tomoscan.py;  \
cd /home/beams/USERTXM/epics/synApps/support/tomoscan/iocBoot/iocTomoScanStream_32ID/; \
bash -c \"source ~/.bashrc; conda activate tomoscan; python -i start_tomoscan.py\";\
bash'" 

