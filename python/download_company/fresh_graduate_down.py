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

def downloadPage(url, saveFileName):

    

    # Add your headers
    headers = {'User-Agent' : 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:46.0) Gecko/20100101 Firefox/46.0'}

    # Create the Request. 
    request = urllib2.Request(url, None, headers)

    # This time, rather than install the OpenerDirector, we use it directly:
    response = urllib2.urlopen(request)
    html = response.read()


    C.writeFile('d:\\temp\\resume_err\\fresh_graduate\\51job\\' + saveFileName, html)

    #htmlRead = C.readFile('d:\\temp\\d3\\ab.html')
    response.close()  # best practice to close the file


def downloadAll():
    srcFilename = "d:\\temp\\resume_err\\fresh_graduate\\lines_01.txt"

    file = open(srcFilename)
    index = 1
    while 1:
        index = index + 1
        line = file.readline()
        if not line:
            break
        line = line.replace("\n","");
        downloadPage(line, str(index) + ".html")
        print line


downloadAll()