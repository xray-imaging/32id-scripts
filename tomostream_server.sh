gnome-terminal --tab --title "tomoStream py server" -- bash -c "ssh -t usertxm@txmthree \
'bash ~/scripts/kill_server.sh start_tomostream.py;  \
cd /home/beams/USERTXM/epics/synApps/support/tomostream/iocBoot/iocTomoStream_32ID; \
bash -c \"source ~/.bashrc; conda activate tomostream; python -i start_tomostream.py\";\
bash'" 
