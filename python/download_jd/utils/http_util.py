# -*- coding: utf-8 -*-

import logging
import urllib2
import urllib
from bs4 import BeautifulSoup
import sys
import os
import re
import time
import random
import traceback
import datetime




# 根据 css 选择器取文字
def getText(element, cssSelector, attr="title"):
    companyEle = element.select(cssSelector)  # 取元素
    if(len(companyEle) < 1):
        return ""
    if(attr == "title"): # 取 title
        return companyEle[0]['title'].encode("utf-8").strip()
    elif(attr == "text"): # 取 text
        return companyEle[0].get_text().encode("utf-8").strip()
    return ""

# 从 list 中取对应元素（如果 liEle 中有 span 与 textStr 相同，则取 liEle 剩余的text）
def getTextFromList(liEles, textStr):
    for liEle in liEles:
        majorSpan = liEle.find("span", text=textStr)
        if(majorSpan != None):
            majorSpan.extract()
            return liEle.get_text().encode("utf-8").strip()
    return ""
# 从 list 中取对应元素（如果 liEle 中包含 textStr，则取 liEle 中 span 的 text）
def getTextFromList02(liEles, textStr):
    for liEle in liEles:
        text = liEle.get_text().encode("utf-8")
        if(textStr in text):
            span = liEle.find("span")
            return span.get_text().encode("utf-8").strip() if span != None else ""
    return ""

# 请求 url 的页面内容
def requestUrlContent(url, proxyBean = None):
    # 模拟浏览器的 header
    headers = {'User-Agent' : 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:46.0) Gecko/20100101 Firefox/46.0'}
    # 创建 http 请求 对象
    request = urllib2.Request(url, None, headers)
    response = None

    if(proxyBean == None):  # 不使用代理
        response = tryUrlOpen(request)
    else:  # 使用代理
        proxyStr = proxyBean["ip"] + ":" + str(proxyBean["port"])
        logging.info("ip is " + proxyStr)
        proxy_handler = urllib2.ProxyHandler({'http': proxyStr})
        opener = urllib2.build_opener(proxy_handler)
        response = tryUrlOpen(request, opener)

    # 获取页面内容
    html = response.read()
    response.close()
    return html

# 打开链接， 失败尝试重连
def tryUrlOpen(request, proxyOpener=None):
    tryCount = 0;
    while(tryCount < 10): # 连接失败时， 重试10次
        tryCount = tryCount + 1
        response = None
        try:
            if(proxyOpener != None):
                response = proxyOpener.open(request)
            else:
                response = urllib2.urlopen(request)
            return response
        except Exception  as e:
            errMsg = str(e)
            if("HTTP Error 30" in errMsg):  # for all 30x Error
                logging.error("use proxy:" + str(proxyOpener != None) + "  Err:" + errMsg)
            # 连接失败时定时重试  Errno 10061
            elif( ("urlopen error" in errMsg)  or ("HTTP Error" in errMsg)):
                sleepMinutes = (tryCount - 5) * 20 if tryCount > 5 else 3 
                logging.error("use proxy:" + str(proxyOpener != None) + " try reconnect " + str(tryCount) + " sleep:" + str(sleepMinutes) + "minutes    Err:" + errMsg)
                time.sleep(sleepMinutes * 60)
            else:
                raise e
    raise  Exception("try reconnect times out!")