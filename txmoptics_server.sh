gnome-terminal --tab --title "txmOptics py server" -- bash -c "ssh -t usertxm@txmtwo \
'bash ~/scripts/kill_server.sh start_txmoptics.py;  \
cd /home/beams/USERTXM/epics/synApps/support/txmoptics/iocBoot/iocTXMOptics/; \
bash -c \"source ~/.bashrc; conda activate tomoscan; python -i start_txmoptics.py\";\
bash'" 