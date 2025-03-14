for k in $(ps -ef|grep "python -i $1"|grep -v grep|grep -v kill_server.sh| sed -e 's/.* \(pts\/[0-9]\+\).*/\1/'); do
    pkill -9 -t $k
done 

