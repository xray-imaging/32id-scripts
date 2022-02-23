gnome-terminal --tab --title "tomoStream IOC" -- bash -c "ssh -t usertxm@txmthree \
'bash ~/scripts/kill_IOC.sh tomoStreamApp;  \
bash ~/scripts/kill_server.sh start_tomostream.py; \
cd /home/beams/USERTXM/epics/synApps/support/tomostream/iocBoot/iocTomoStream_32ID; \
./start_IOC;\
bash'" 