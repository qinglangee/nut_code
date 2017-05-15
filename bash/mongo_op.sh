#! /bin/zsh
file=./test
function zh_innerlog {
    echo $1
}
hahaha=123;
while [ $hahaha -gt 10  ] ;do
line=`tail -1 $file`
zh_innerlog $line
res=`echo $line|awk '{print $10}'`
zh_innerlog res $res
#res=222m
num=`echo $res |perl -e 'print "$1" if/(\d+).*g/;print "nog" unless/\d+.*g/ ' -n`
if [ $num = "nog" ]; then
    num="nog"
else
    zh_innerlog num is $num
    flag=10
    zh_innerlog "$num" -gt "$flag"
    if [ "$num" -gt 55 ]; then
        zh_innerlog  "$num > 10"
        #/etc/init.d/mongod restart
        #sleep 60
        #nohup  /usr/local/mongodb-linux/bin/mongostat >>/tmp/mongostat &
    else
        zh_innerlog 2323
    fi
fi


date >> /tmp/zhch_mongo_op

sleep 601 # //间隔秒数

#hahaha=1


done

