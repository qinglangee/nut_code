#! /bin/sh

echo "killall memcached"
killall memcached
sleep 3

echo "init l06 mem"
/usr/local/memcached/bin/memcached -d -m 1024 -u nobody -p 10101
/usr/local/memcached/bin/memcached -d -m 1024 -u nobody -p 10102

echo "init @ function mem"
/usr/local/memcached/bin/memcached -d -m 1024 -u nobody -p 10113
/usr/local/memcached/bin/memcached -d -m 1024 -u nobody -p 10114

echo "init game mem"
/usr/local/memcached/bin/memcached -d -m 1024 -u nobody -p 10103
/usr/local/memcached/bin/memcached -d -m 1024 -u nobody -p 10104

echo "init session share mem"
/usr/local/memcached/bin/memcached -d -m 1024 -u nobody -p 20001
/usr/local/memcached/bin/memcached -d -m 1024 -u nobody -p 20002
