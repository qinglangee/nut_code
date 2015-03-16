#!/bin/bash
 
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
