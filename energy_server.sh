gnome-terminal --tab --title "energy py server" -- bash -c "ssh -t usertxm@txmtwo \
'bash ~/scripts/kill_server.sh start_energy.py;  \
cd /home/beams/USERTXM/epics/synApps/support/energy/iocBoot/iocEnergy_32ID/; \
bash -c \"source ~/.bashrc; conda activate tomoscan; python -i start_energy.py\";\
bash'" 
