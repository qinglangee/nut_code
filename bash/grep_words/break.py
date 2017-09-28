# encoding=utf-8
import re

article_file="zhignore/article"


# 读取文件内容

def readFile(filename):
    with open(filename, 'r') as file:
        content = file.read()
    return content

def lowerFirstWord(inStr):
    return "%s" % (inStr[:1].lower() + inStr[1:])

content = readFile(article_file)

newword = True
word=""
for char in content:
    if re.match("[a-zA-Z]", char) :
        if newword:
            if len(word) > 0:
                if lowerFirstWord(word) == word.lower():
                    print lowerFirstWord(word)
                else:
                    print word
            word = "" + char
        else:
            word = word + char
        newword = False
    else:
        newword = True
        #print "word is:" + word
        #print "hahaha" + line
