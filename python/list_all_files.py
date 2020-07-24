
'''
import os
1、os.listdir('/root/python/') #列出当前目录下所有文件
2、os.path.isdir('/abc') #判断是否是目录，返回布尔值，不存在也返回false
3、os.path.isfile('/etc/passwd') #判断是否是文件
4、os.path.join('/etc/', 'passwd') #连接文件，返回/etc/passwd
5.os.path.splitext('aa.txt') # 切分后缀，返回数组 [1] 是后缀 [0]是后缀前面的部分
'''

import os

#dirname = 'c:/windows/'
dirname = "d:/temp/d3/"



print(os.path.isdir(dirname))
items = os.listdir(dirname)
for item in items :
	full = dirname + item
	
	if(os.path.isdir(full)):
		print("dir: " + item)
	else:
		name = os.path.splitext(item)
		print("===file: " + item  + " pure name: " + name[0] + "  ext: " + name[1])

		name = os.path.splitext(full)
		print("===file: " + item  + " pure name: " + name[0] + "  ext: " + name[1])
	
	