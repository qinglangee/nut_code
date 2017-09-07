# coding:utf-8

import hashlib
data =  'This a md5 test!'
hash_md5 = hashlib.md5(data)

mm = hash_md5.hexdigest()
print mm



# 用的　md5 库, md5是已过时了，　被hashlib代替
import md5
m = md5.new()
m.update("Nobody inspects")
m.update(" the spammish repetition")
res = m.digest()
print res

m2 = md5.new()
m2.update("This a md5 test!")
print m2.hexdigest()