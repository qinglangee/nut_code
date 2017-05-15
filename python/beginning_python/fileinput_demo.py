# -*- coding= utf8 -*-

import logging

logging.basicConfig(level=logging.DEBUG,
                format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                datefmt='%a, %Y-%m-%d %H:%M:%S',
                filename='myapp.log',
                filemode='a')
#logging.warn(u"不在两种格式里面，找不到公司信息")


import fileinput

# 测试使用  python fileinput_demo.py  fileinput_demo_test_src.py

for line in fileinput.input(inplace=False):
	line = line.rstrip()
	num = fileinput.lineno()
	print '%-40s # %2i' % (line, num)
