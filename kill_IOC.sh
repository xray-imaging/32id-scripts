for k in $(ps -all|grep $1 | sed -e 's/.*\(pts\/[0-9]\+\).*/\1/'); do
    pkill -9 -t $k
done 

