gnome-terminal --tab --title "energy IOC" -- bash -c "ssh -t usertxm@txm4 \
'bash ~/scripts/kill_IOC.sh energyApp;  \
bash ~/scripts/kill_server.sh start_energy.py; \
bash'" 

