import random
import re

def demo():
    matchObj = re.match( r'(.*) are (.*?) .*', line, re.M|re.I)

    if matchObj:
        print "matchObj.group() : ", matchObj.group()
        print "matchObj.group(1) : ", matchObj.group(1)
        print "matchObj.group(2) : ", matchObj.group(2)
    else:
        print "No match!!" 



dds = ["1987-12", "1987-1-13", "1987-12-01", "1987-12-3", "1987-12", "81987-12", "1987-192", "1987", "abcd"]

for dd in dds:
    print dd + "   --" + fixDate(dd)