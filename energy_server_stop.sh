gnome-terminal --tab --title "energy py server" -- bash -c "ssh -t user2bmb@pg10ge \
'bash ~/scripts/kill_server.sh start_energy.py;  \
bash'" 
