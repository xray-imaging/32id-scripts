for k in $(ps -ef|grep "screen -x $1"|grep -v grep|grep -v kill_screen.sh| sed -e 's/.* \(pts\/[0-9]\+\).*/\1/'); do
    pkill -9 -t $k
done 

