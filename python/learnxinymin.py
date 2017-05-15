# -*- coding: utf-8 -*-
# 实际上Python只检查#、coding和编码字符串，其他的字符都是为了美观加上的

# 字符串打印
print 'abc',u'def咀'
print u'我是中文'
print  '"abcd\r\nefg"' # 单引号和双引号貌似功能一样， 都能转义字符
print "'abcd\r\nefg'"
print "0000"+'1111'  # 字符串用 + 连接

# 字符串可以被视为字符的列表
print "This is a string"[0]  # => 'T'

# % 可以用来格式化字符串
print "%s can be %s" % ("strings", "interpolated")
# 也可以用 format 方法来格式化字符串,推荐使用这个方法
print "{0} can be {1}".format("strings", "formatted")

# 布尔割开
print True  # 只能是大写开开头， true是不对的
print not True  # 用 not 取反， !Ture 是不对的

# 比较运算可以连起来写！ 这个很奇葩
1 < 2 < 3  # => True
2 < 3 < 2  # => False

# set 中的值不能重复
print "set ====================================="
set001 = {1,2}
print set001
set001.add(3)
set001.add(2)
print set001

print "function ====================================="
# 用 def 来新建函数
def add(x, y):
    print "x is %s and y is %s" % (x, y)
    return x + y    # 通过 return 来返回值
# 通过关键字赋值来调用函数
add(y=6, x=5)   # 顺序是无所谓的, 但名字不能乱写，  add(m=6, x=5) 是不对的

