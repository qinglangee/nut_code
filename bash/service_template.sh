#!/bin/bash
#chkconfig:345 61 61 //此行的345参数表示,在哪些运行级别启动,启动序号(S61);关闭序号(K61)；之前序号用124和224都报错，后来改成两位的就成功了，不知道为什么
#description:service_name //此行必写,描述服务.
# 把这个文件放到  /etc/rc.d/init.d/ 目录中
# chkconfig --add  service_name
# chkconfig --list service_name
 
ReturnVal=0
 
start()
{
    # Star the service. 
    echo "Service is being started..."
}
 
stop()
{
    # Stop the service here.
    echo "Service is being stopped..."
}
 
restart()
{
    echo "Service is being Restarted..."
    stop
    start
}
 

# Main Wrapper
 
#case '$1' in 
case $1 in 
 
start)
start
;;
 
stop)
stop
;;
 
restart)
restart
;;
 
*)
echo "Invalid Option related to the Service."
echo $"Usage: $0 {start|stop|restart}"
 
exit 1
esac
 
exit $ReturnVal
