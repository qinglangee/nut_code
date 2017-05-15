# -*- coding: utf-8 -*-
import config
import http_util as HTTP
import common_util as C

# 取第一层分类
def collectHeaderTypes(soup):
    liEles = soup.select("div.home_nav_con li")
    result=[]
    index = 0
    for liEle in liEles:
        link = liEle.find("a")
        topType = {}
        topType["no"] = index
        topType["name"] = link.get_text().encode("utf-8")
        topType["url"] = link["href"].encode("utf-8")
        index = index + 1
        result.append(topType)
    return result 

# 取第二层分类
def collectSubTypes(soup, headerType):
    outerEle = soup.find("dl", class_="detail_sort")
    result = []
    parentName = ""
    for child in outerEle.children:
        if(child.name == "dt"):
            parentName = child.get_text().encode("utf-8")
        if(child.name == "dd"):
            links = child.find_all("a")
            for link in links:
                linkName = link.get_text().encode("utf-8")

                subType = {}
                subType["parent"] = parentName
                subType["name"] = linkName
                subType["url"] = link['href'].encode("utf-8")
                if(headerType != None):
                    subType['pno'] = headerType["no"]
                    subType["pname"] = headerType["name"]
                result.append(subType)

    return result

# 根据页面取 JD 链接
def collectJdItems(soup, param=None):
    links = soup.select(".list_middle td.td_sp1 a")
    obj = {}
    result = []
    for link in links:
        item = {}
        item["name"] = link["title"].encode("utf-8")
        item["url"] = config.detail_pre + link['href'].encode("utf-8")
        result.append(item)

    nextPage = soup.find("a", class_="a_icon04")
    if(nextPage != None):
        obj["has_next"] = True
        obj["url"] = nextPage["href"].encode("utf-8")
    else:
        obj["has_next"] = False
        
    obj["items"] = result
    return obj

# 获取 JD 详细内容
def collectDetail(soup, item=None):
    detail = {}

    # 组合 csv 记录
    csvContent = "jd"
    csvContent = C.appendCsv(csvContent, HTTP.getText(soup, "div.wrap_title h3 a", "text"))   # 公司
    csvContent = C.appendCsv(csvContent, HTTP.getText(soup, "div.wrap_title h1", "text"))   # 职位名

    liEles = soup.select("ul.job_info li")
    csvContent = C.appendCsv(csvContent, getTextFromList(liEles, "专业要求："))
    csvContent = C.appendCsv(csvContent, getTextFromList(liEles, "学历要求："))
    csvContent = C.appendCsv(csvContent, getTextFromList(liEles, "工作经验："))
    csvContent = C.appendCsv(csvContent, getTextFromList(liEles, "外语要求："))

    desEle = soup.select("dl.zxd_jobinfo")
    desStr = ""
    if(len(desEle) > 0):
        desStr = desEle[0].get_text().encode("utf-8").strip()

    desStr = desStr.replace("\r\n","").replace("\n","").replace("\r","")
    csvContent = C.appendCsv(csvContent, desStr)

    detail["csv"] = csvContent

    return detail

# 从 list 中取对应元素（如果 liEle 中有 span 与 textStr 相同，则取 liEle 剩余的text）
def getTextFromList(liEles, textStr):
    for liEle in liEles:
        majorSpan = liEle.find("span", text=textStr)
        if(majorSpan != None):
            majorSpan.extract()
            return liEle.get_text().encode("utf-8").strip()
    return ""