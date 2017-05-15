# -*- coding: utf-8 -*-
import config
import sys
for src_path in config.src_paths:
    sys.path.append(src_path)
import http_util as HTTP
import common_util as C
from bs4 import BeautifulSoup
import logging
# import urllib2
# import urllib
# import sys
import os
import re
# import time
# import random
import traceback
import datetime
import json

batchTypes = ["10038","10036","10148","10037","10149"]
proxyBean={"ip":"114.215.108.168", "port":36666}

def appCsv(old, abcd):
	content = ""
	if isinstance(abcd, str):
		content = abcd
	elif isinstance(abcd, unicode):
		content = abcd.encode("utf-8")
	else:
		print "abcd type is : " + str(type(abcd))
	if(content != None):
		return old + "," + '"' + content + '"'
	else:
		return old + "," + '""'

def itemAttr(item, attr):
	if(item.has_key(attr)):
		return item[attr]
	else:
		return ""



def getSchoolInfo(typeName, schoolType):

	index = 0
	url_pre = "http://data.api.gkcx.eol.cn/soudaxue/queryschool.html?schooltype=" + schoolType + "&messtype=json&_=1484891974983&size=20&page="

	hasNext = True
	content = ""

	while(hasNext):
		index = index + 1
		url = url_pre + str(index)
		print url
		print("get  index :" + str(index))

		html = HTTP.requestUrlContent(url, proxyBean)
		# print html
		ret = json.loads(html)
		if(not ret.has_key("school") or len(ret["school"]) == 0):
			break

		print "school length:" + str(len(ret["school"]))
		for item in ret["school"]:
			try:
				csv = "school"
				csv = appCsv(csv, itemAttr(item,"schoolname"))
				csv = appCsv(csv, itemAttr(item,"schooltype"))
				csv = appCsv(csv, itemAttr(item,"membership"))
				csv = appCsv(csv,  "985工程" if item["f985"] == "1" else "")
				csv = appCsv(csv,  "211工程" if item["f211"] == "1" else "")
				csv = appCsv(csv, getBatchInfo(item))
				print csv
				content += csv + "\n"
				C.appendFile("d:\\temp\\d3\\bb001\\" + typeName + ".csv", content)
			except Exception  as e:
				print e		

	C.appendFile("d:\\temp\\d3\\bb001\\" + typeName + "_all.csv", content)

def getBatchInfo(item):
	schoolUrl = "http://gkcx.eol.cn/schoolhtm/schoolTemple/school"+item["schoolid"]+".htm"
	html = HTTP.requestUrlContent(schoolUrl, proxyBean)

	proReg = "schoolprovince='(\d+)'"

	batchInfo = ""
	examineeType = "10035"
	province = ""
	proMatch =  re.search(proReg, html)
	if(proMatch != None):
		province = proMatch.groups()[0]

	for batchType in batchTypes:
		print "try " + batchType
		xmlName="provinceScores"+item["schoolid"]+"_"+province+"_"+examineeType+"_"+batchType+".xml";
		url = 'http://gkcx.eol.cn/schoolhtm/scores/'+xmlName;

		typeXml = HTTP.requestUrlContent(url, proxyBean)
		if(len(typeXml) > 10):
			soup = BeautifulSoup(typeXml, "lxml")
			rb = soup.find("rb")
			if(rb != None):
				batchInfo = rb.get_text().encode("utf-8")
				break

	return batchInfo




tts=["dulixunyuan", "gaozhi"]
schoolTypes = [ "%E7%8B%AC%E7%AB%8B%E5%AD%A6%E9%99%A2"]
# schoolTypes = ["%E6%99%AE%E9%80%9A%E6%9C%AC%E7%A7%91"]

for i in range(1):
	getSchoolInfo(tts[i], schoolTypes[i])