#! /usr/bin/python
import os

srcSize = 64
srcUnit = 8
destSizes={"drawable-xhdpi": 6, "drawable-hdpi": 4, "drawable-mdpi": 3}

for root, dirs, files in os.walk("./src", True):
    for name in files:
        print(os.path.join(name))
        print(name)
        for key in destSizes.keys():
            os.system("mkdir " + key)
            destSize = srcSize*destSizes[key]//srcUnit
            print(destSize)
            os.system("convert -resize "+ str(destSize)+" ./src/"+name+" " + key + "/" + name)

