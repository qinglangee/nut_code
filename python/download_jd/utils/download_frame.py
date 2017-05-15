# -*- coding: utf-8 -*-
import config
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

# 设置日志配置
logging.basicConfig(level=logging.DEBUG,
                format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                datefmt='%a, %Y-%m-%d %H:%M:%S',
                filename='myapp.log',
                filemode='a')

proxyBean = None
if(hasattr(config, "proxyBean")):
    proxyBean = config.proxyBean

# 不需要的分类
exclude_words = ["市场","运营","人事","人力","行政","后勤","物流","供应链","财务","金融","会计","法律","采购","销售","营销"];

# 下载 jd 总入口
def start(fun):
    html = HTTP.requestUrlContent(config.start_url, proxyBean)
    soup = parseSoup(html) # 解析页面内容，返回一个BeautifulSoup对象，可以用来获取和操作 html 内容

    # 取第一层分类
    headerTypes = fun.collectHeaderTypes(soup)

    C.writeList("top_type.txt", headerTypes, strType)
    C.writeFile("sub_type.txt", "")
    for headerType in headerTypes:
        html = HTTP.requestUrlContent(headerType["url"], proxyBean)
        soup = parseSoup(html)
        # 取第二层分类
        subTypes = fun.collectSubTypes(soup, headerType)

        C.appendList("sub_type.txt", subTypes, strType)
        for subType in subTypes:
            typeStr = subType["parent"] + "__" + subType["name"]
            isExclude = False
            for ex_word in exclude_words:
                if(ex_word in typeStr):
                    isExclude = True
                    break
            if(isExclude):
                print "========== not download this type :" + typeStr
                continue
            else:
                logging.info("download " + typeStr)
                downloadType(fun, subType, subType['url'], 0, 0)

# 下载一个分类        
def downloadType(fun, subType, url, page, count):
    logging.info("download " + subType["parent"] + " " + subType["name"] + " page " + str(page) + " count " + str(count))
    #print("download " + subType["parent"] + " " + subType["name"] + " page " + str(page) + " count " + str(count))
    dirPath = config.file_save_path + "\\" + (subType['parent'].strip() + "--" + subType['name'].strip()).replace("/", "_").decode("utf-8").encode("gb2312")   # 目录名
    if(os.path.isdir(dirPath) and page == 0):
        logging.info("这个分类已经下载过了==========================================")
        return
    html = HTTP.requestUrlContent(url, proxyBean)
    soup = parseSoup(html)
    param = {"page":page}

    itemsResult = fun.collectJdItems(soup, param)
    jdItems = itemsResult["items"]
    for jdItem in jdItems:
        # print jdItem["name"]
        downloadDetail(fun, subType, jdItem)
        count = count + 1
        
        logging.info("use proxy:" + (proxyBean["ip"] if proxyBean != None else "False") + subType["parent"] + " " + subType["name"] + " 页数：" + str(page) + " count：" + str(count) + " title：" + jdItem["name"])
    
    logging.info("has next page :" + str(itemsResult["has_next"]))
    if(itemsResult["has_next"]):
        downloadType(fun, subType, itemsResult["url"], page + 1, count)


def downloadDetail(fun, subType, jdItem):
    try:
        soup = None
        if(jdItem.has_key("url")):
            html = HTTP.requestUrlContent(url, proxyBean)
            soup = parseSoup(html)
        detail = fun.collectDetail(soup, jdItem)
        csvContent = detail["csv"]

        #print csvContent

        # 生成文件名
        parentStr = subType['parent'].strip()
        typeStr = subType['name'].strip()
        dirName = (parentStr + "--" + typeStr).replace("/", "_").decode("utf-8").encode("gb2312")   # 目录名
        nowTime = str(datetime.datetime.now()).replace(" ", "_").replace(":", "_")   # 当前时间
        dirPath = config.file_save_path + "\\" + dirName
        if(not os.path.isdir(dirPath)):  # 如果目录不存在， 先创建目录
            os.makedirs(dirPath)


        filePath =  dirPath + "\\" + nowTime + ".html"  # 组合成文件名
        logging.info("filename :" + nowTime + ".html  url:" + url)

        
        # 保存 csv 记录
        csvFilePath = config.file_save_path + "\\" + dirName  + ".csv"   
        C.appendFile(csvFilePath, csvContent + "\n")
    except Exception  as e:
        exstr = traceback.format_exc()
        logging.error(exstr)

def parseSoup(html):
    soup = None
    if(hasattr(config, "page_encode")):
        soup = BeautifulSoup(html, "lxml", from_encoding=config.page_encode)
    else:
        soup = BeautifulSoup(html, "lxml")
    return soup

# 分类数据 字符串化
def strType(obj):
    result = "{"
    index = 0
    for key in obj:
        if(index > 0):
            result = result + ","
        result = result + "'" + key + "':'" + str(obj[key]) + "'"
        index = index + 1
    result = result + "}"
    return result
    