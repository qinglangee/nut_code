# -*- coding: utf-8 -*-
import config
import mysql.connector
import common_util as C
import logging
import urllib2
import urllib
from bs4 import BeautifulSoup
import sys
import os
import re
import company_dao
import company_service
import time
import random
import traceback

logging.basicConfig(level=logging.DEBUG,
                format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                datefmt='%a, %Y-%m-%d %H:%M:%S',
                filename='myapp.log',
                filemode='a')
    

companyFields = ["name", "industry", "found_time","scale","address","city",
    "description","kanzhun_id","file","attr","homepage"]

ipList = ['115.28.147.40','120.27.4.147','120.26.235.45','115.29.37.227','114.215.131.160']
ipIndex = 0
# cnx = mysql.connector.connect(user='root',password='zhch',host='127.0.0.1',database='sqtzhch')
# cur=cnx.cursor()
# cur.execute('select * from zhch')
# print cur.fetchall()


def downloadCompanyInfo(comId):

    ipSelected = ipList[ipIndex]

    url = 'http://www.kanzhun.com/'+comId+'.html'

    # Add your headers
    headers = {'User-Agent' : 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:46.0) Gecko/20100101 Firefox/46.0'}

    # Create the Request. 
    request = urllib2.Request(url, None, headers)






    # # , proxies={"http":"114.215.131.160:36666"}
    # response = urllib2.urlopen(request)
    # # print response.info()
    # html = response.read()



    proxyStr = ipSelected + ":36666"
    logging.info("ip is " + proxyStr + " index is " + str(ipIndex))
    proxy_handler = urllib2.ProxyHandler({'http': proxyStr})
    opener = urllib2.build_opener(proxy_handler)
    # This time, rather than install the OpenerDirector, we use it directly:
    response = opener.open(request)
    html = response.read()


    saveFileName = "kanzhun_no" + os.sep + comId + ".html"
    C.writeFile(config.file_save_path + saveFileName, html)

    #htmlRead = C.readFile('d:\\temp\\d3\\ab.html')
    response.close()  # best practice to close the file
    soup = BeautifulSoup(html, "lxml")

    comLayer = soup.find(id="co-company-layer")
    company = None
    if(comLayer != None):
        company = company_service.parseCompanyFromLayer(soup, comId)
    elif(soup.find(id="company-profile") != None):
        company = company_service.parseCompanyFromPage(soup, comId)
    else:
        logging.warn("comId " + comId + "  不在两种格式里面，找不到公司信息")
        sleepTime = 10000 + random.randint(0,30)
        # 记录错误文件内容
        errorFileName = "kanzhun_err" + os.sep + comId + ".html"
        C.writeFile(config.file_save_path + errorFileName, html)

        logging.warn("可能是验证码了，sleep时间长一点。。。{}  errFile:{}".format(sleepTime, errorFileName))
        time.sleep(sleepTime)

    if(company != None):
        company["file"] = saveFileName
        for key in companyFields:
            if(not company.has_key(key)):
                company[key] = ""
        comInfoStr = "comId:" + comId + "  name:" + company["name"] 

        logging.info(comInfoStr)

        if(company["name"] == ""):
            logging.warn("empty name, throw the info")
        else:
            company_dao.insert(company)
    else:
        logging.info("company is None . comId:" + comId)

comId = "gso60159"
comId = "gso20863"
comId = "gso36477"

def mainEntry():
    i=22488  # 404 id
    i=42245
    global ipIndex
    while(i < 1000000):
        comId = "gso" + str(i)
        try:
            downloadCompanyInfo(comId)
        except Exception  as e:
            exstr = traceback.format_exc()
            # print exstr
            logging.error('comId:{} download error!'.format(comId))
            if('HTTP Error 403' in str(e)):
                i -= 1   # 403时不增加序号
                ipIndex = (ipIndex + 1) % len(ipList)
                logging.error(e)
            elif('HTTP Error 404' in str(e)):
                logging.error(e)
            else:
                logging.error('comId:{} download error!\n{}'.format(comId, exstr))
        
        sleepTime = 40 + random.randint(0,20)
        #sleepTime = 5
        logging.info("sleep {}".format(sleepTime))
        time.sleep(sleepTime)
        i += 1

mainEntry()

def test():
    a=0
    index = "abcdaabc".find("aa") 
    print "index " + str(index)

#test()