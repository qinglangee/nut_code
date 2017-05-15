import fileinput                         #  1 #  9
                                         #  2 # 10
# 测试使用  python fileinput_demo.py  test_src.py #  3 # 11
                                         #  4 # 12
for line in fileinput.input(inplace=True): #  5 # 13
	line = line.rstrip()                    #  6 # 14
	num = fileinput.lineno()                #  7 # 15
	print '%-40s # %2i' % (line, num)       #  8 # 16
