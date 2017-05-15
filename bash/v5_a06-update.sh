rm -rf /tmp/l06.tar.gz
echo "删除本地L06文件/tmp/l06.tar.gz完成!"
sleep 3

cp -rvf /ReleaseWork/output/l06.js/* /ReleaseWork/output/l06/js/
cp -rvf /ReleaseWork/conf/l06/192.168.1.17/* /ReleaseWork/output/l06/WEB-INF/classes/
cd /ReleaseWork/output/l06/ && tar czvf /tmp/l06.tar.gz *
echo "压缩本地L06文件完成！"
sleep 3

ssh root@192.168.1.17 "service httpd stop"
echo "停止远程httpd服务完成！"
sleep 3

ssh root@192.168.1.17 "service tomcat stop"
echo "停止远程tomcat服务完成！"
sleep 3

today=`date +'%G-%m-%d-%H-%M'`
echo "获得本地目前时间${today} 完成"
sleep 3

ssh root@192.168.1.17 "cp -rvf /www/webapps/v5_a06/ /root/webappsbackup/v5_a06/v5_a06.bak${today}.wangyongge"
echo "备份远程文件至/root/webappsbackup/v5_a06/v5_a06.bak${today}.wangyongge 完成!"
sleep 3

ssh root@192.168.1.17 "rm -rvf /www/webapps/v5_a06/ROOT/*"
echo "删除当前17 L06文件 完成！"
sleep 3

scp -v /tmp/l06.tar.gz root@192.168.1.17:/www/webapps/v5_a06/ROOT/
echo "拷贝Release服务器L06项目到 17 完成！"
sleep 3

ssh root@192.168.1.17 "cd /www/webapps/v5_a06/ROOT/ && tar xzvf l06.tar.gz"
ssh root@192.168.1.17 "cd /www/webapps/v5_a06/ROOT/js/ && cp -rvf * /www/static2.dev.xy.l99.com/js/ --reply yes"
ssh root@192.168.1.17 "cd /www/webapps/v5_a06/ROOT/skin/ && cp -rvf * /www/static2.dev.xy.l99.com/skin/ --reply yes"
echo "解压项目完成！"
sleep 3

ssh root@192.168.1.53 "/usr/bin/killall memcached"
ssh root@192.168.1.53 "/bin/ps -aux | grep memcached"
echo "Memcached 已经全部被干掉"
sleep 3
ssh root@192.168.1.53 "/usr/local/memcached/bin/memcached -d -u nobody -m 512 -p 10099"
ssh root@192.168.1.53 "/usr/local/memcached/bin/memcached -d -u nobody -m 512 -p 10100"
ssh root@192.168.1.53 "/usr/local/memcached/bin/memcached -d -u nobody -m 512 -p 10101"
ssh root@192.168.1.53 "/usr/local/memcached/bin/memcached -d -u nobody -m 512 -p 10102"
ssh root@192.168.1.53 "/usr/local/memcached/bin/memcached -d -u nobody -m 512 -p 10103"
ssh root@192.168.1.53 "/usr/local/memcached/bin/memcached -d -u nobody -m 512 -p 10104"
ssh root@192.168.1.53 "/usr/local/memcached/bin/memcached -d -u nobody -m 512 -p 20101"
ssh root@192.168.1.53 "/usr/local/memcached/bin/memcached -d -u nobody -m 512 -p 20102"
ssh root@192.168.1.53 "/bin/ps -aux | grep memcached"
echo "Memcached 已经全部启动"
sleep 3

ssh root@192.168.1.17 "service tomcat start"
echo "打开远程tomcat服务完成！"
sleep 30

ssh root@192.168.1.17 "service httpd start"
echo "打开远程httpd服务完成！"
sleep 3

ssh root@192.168.1.17 "rm -rf /www/webapps/v5_a06/l06.tar.gz"
echo "删除远程L06部署 tar包完成！"
sleep 3

ssh root@192.168.1.17 "rm -rf /www/webapps/v5_a06/ROOT/flash/Game/*"
ssh root@192.168.1.17 "rm -rf /www/webapps/v5_a06/ROOT/WEB-INF/pages/game/wwereGame/*"

scp -r /ReleaseWork/output/game.pub/Game/* root@192.168.1.17:/www/webapps/v5_a06/ROOT/flash/Game/
scp -r /ReleaseWork/output/game.pub/wwereGame/* root@192.168.1.17:/www/webapps/v5_a06/ROOT/WEB-INF/pages/game/wwereGame/

echo "清除静态缓存"
ssh root@192.168.1.17 "/bin/bash /root/shells/clean_static_cache.sh"
