# coding:utf-8
import urllib2
import html.parser

# urllib2.urlopen(url[, data[, timeout[, cafile[, capath[, cadefault[, context]]]]])
f = urllib2.urlopen('http://www.baidu.com/')
print u"baidu 前 10 个字节================================================="
print f.read(10)