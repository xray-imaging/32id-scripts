gnome-terminal --tab --title "ADetector IOC" -- bash -c "ssh -t usertxm@txmtwo \
'bash ~/scripts/kill_screen.sh 32idcSP1;  \
/xorApps/epics/synApps_6_2_1/ioc/32idcSP1/iocBoot/ioc32idcSP1/softioc/32idcSP1.sh stop; \
sleep 1; \
/xorApps/epics/synApps_6_2_1/ioc/32idcSP1/iocBoot/ioc32idcSP1/softioc/32idcSP1.sh start; \
sleep 1; \
/xorApps/epics/synApps_6_2_1/ioc/32idcSP1/iocBoot/ioc32idcSP1/softioc/32idcSP1.sh console; \
bash'" 

