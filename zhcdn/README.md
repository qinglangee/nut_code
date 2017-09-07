# 本在cdn说明
这里缓存一些需要翻墙的文件，缓解打开一些网站慢

1. 在host中把　host1 中的域名指向本机
参见 alias.sh 中的　zhh1
2. nginx 中代理这些域名到缓存的目录，相应的配置链接到这里的conf就可以

3. cert 生成的方法见　2016-02-03-nginx_ssl_https.md



## 文件下载
连接vpn后，在本目录下执行 `wget -r file_url`, -r 参数会自动生成文件的目录结构


## 文件列表

### ajax.googleapis.com
https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js

### platform.twitter.com
https://platform.twitter.com/widgets.js