# -*- coding: utf-8 -*-
import config
import http_util as HTTP
import common_util as C
import urllib

# 取第一层分类
def collectHeaderTypes(soup):
    result=[]
    index = 0


    topType = {}
    topType["no"] = index
    topType["name"] = "all"
    topType["url"] = "http://gkcx.eol.cn/soudaxue/queryschool.html?page=1&schoolSign=2"
    result.append(topType)
    print result
    return result

# 取第二层分类
def collectSubTypes(soup, headerType):
    result = []
    parentName = ""
    argschtypes = ["普通本科", "独立学院", "高职高专"]
    for argschtype in argschtypes:

        subType = {}
        subType["parent"] = "all"
        subType["name"] = argschtype
        data = {"schoolSign":2, "argschtype":argschtype}
        subType["url"] = config.subtype_pre + urllib.urlencode(data)
        if(headerType != None):
            subType['pno'] = headerType["no"]
            subType["pname"] = headerType["name"]
        result.append(subType)

    print result
    return result

# 根据页面取 JD 链接
def collectJdItems(soup, param):
    trs = soup.select("table#queryschoolad tr")
    obj = {}
    result = []

    print "trs size:" + str(len(trs))
    for tr in trs:
        tds = tr.find_all("td")
        if(len(tds) < 7):
            continue
        link = tr.find("a")
        if(link == None):
            continue
        item = {}
        item["name"] = link["title"].encode("utf-8").strip()
        item["url"] = config.detail_pre + link['href'].encode("utf-8")

        item["level"] = tds[3].get_text().encode("utf-8").strip()
        itemAttr = tds[4].get_text().encode("utf-8").strip()
        itemAttr = itemAttr + "|" + tds[5].get_text().encode("utf-8").strip()
        itemAttr = itemAttr + "|" + tds[6].get_text().encode("utf-8").strip()
        item["attr"] = itemAttr


        result.append(item)

        print "items size:" + str(len(result))

    if(len(result) > 0):
        obj["has_next"] = True
        data = {"schoolSign":2, "argschtype":argschtype, "page":(param["page"] + 2)}
        # obj["url"] = config.subtype_pre + urllib.urlencode(data)
    else:
        obj["has_next"] = False
        
    obj["items"] = result
    # print "result size:" + str(len(result))
    return obj

# 获取 JD 详细内容
def collectDetail(soup, item):
    detail = {}

    # 组合 csv 记录
    csvContent = "school"
    csvContent = C.appendCsv(csvContent, item["name"] if item.has_key("name") else "")  
    csvContent = C.appendCsv(csvContent, item["level"] if item.has_key("level") else "")  
    csvContent = C.appendCsv(csvContent, item["attr"] if item.has_key("attr") else "")  

    #csvContent = C.appendCsv(csvContent, desStr)

    detail["csv"] = csvContent
    print csvContent

    return detail

# 从 list 中取对应元素
def getItemAttr(item, attr):

    return result