# -*- coding: utf-8 -*-
import re
import logging



def fixDate(src):
    matcher = re.match(r'\d\d\d\d-\d\d?-\d\d?', src)
    if(matcher):
        return matcher.group()
    else:
        matcher = re.match(r'\d\d\d\d-\d\d?', src)
        if(matcher):
            return matcher.group() + "-01" # 没有日的日期设为 1 号
        else:
            logging.debug("wrong date value:" + src)
            return ""

# 公司的信息在弹出的的浮动层里，解析浮动层的信息
def parseCompanyFromLayer(soup, comId):
    comLayer = soup.find(id="co-company-layer")

    comNameEle = comLayer.find("div", class_="co_name") # 公司名
    comTypeEle = comLayer.find("span", class_="type") # 行业
    comCityEle = comLayer.find("span", class_="location") # 城市
    comScaleEle = comLayer.find("span", class_="members") # 规模
    comAddrEle = comLayer.find("div", class_="co_addr") # 公司地址
    comBasicInfoEle = comLayer.find("div", class_="co_base_info") # 基本信息div
    comDescEle = comLayer.find("div", class_="co_info") # 公司简介

    comName = comNameEle.string.encode("utf-8").strip()
    comType = comTypeEle.string.encode("utf-8") # 行业
    comCity = comCityEle.string.encode("utf-8") if comCityEle.string != None else ""
    comScale = comScaleEle.string.encode("utf-8") if comScaleEle.string != None else ""
    comAddr = comAddrEle.string.encode("utf-8").replace("公司地址", "").strip()
    comTime = ""
    comTimeEle = comBasicInfoEle.find("em", text=re.compile(u"时间"))
    if(comTimeEle != None):
        comTime = comTimeEle.string.encode("utf-8").replace("时间","").strip()
        comTime = fixDate(comTime)

    if(comDescEle != None):
        moreInfoEle = comDescEle.find("a")  # 更多信息链接
        if(moreInfoEle != None): 
            comDescEle.find("a").extract()
        comDesc = comDescEle.get_text().encode("utf-8")

    # print config.file_save_path

    # print 'name:' + comName + ' comType:' + comType + " city：" + comCity + " scale:" + comScale
    # print  " addr:[" + comAddr + "]" + " time:" + comTime
    # print comDesc
    company={"name":comName, "industry":comType, "found_time":comTime,"scale":comScale,"address":comAddr,"city":comCity,
    "description":comDesc,"kanzhun_id":comId,"attr":"","homepage":""}

    return company

# 公司的信息在页面下方一体式的
def parseCompanyFromPage(soup, comId):
    company = {}
    comDiv = soup.find(id="company-profile")
    brife = comDiv.find("section", class_="company_brief_info")

    spans = brife.select("ul > li > span")
    spanLen = len(spans)
    for i in range(0, spanLen):
        if(spans[i].string == None):
            continue
        text = spans[i].string.encode("utf8")
        # print text
        if(text.find("所属行业") >= 0):
            company["industry"] = getNextText(spans, i)
        elif(text.find("公司性质") >= 0):
            company["attr"] = getNextText(spans, i)
        elif(text.find("成立时间") >= 0):
            company["found_time"] = fixDate(getNextText(spans, i))
        elif(text.find("规模") >= 0):
            company["scale"] = getNextText(spans, i)
        elif(text.find("公司地点") >= 0):
            company["address"] = getNextText(spans, i)

    descEle = brife.find("article")
    if(descEle != None):
        moreEle = descEle.find("span", class_="more")
        if(moreEle != None):
            moreEle.extract()
        company["description"] = descEle.get_text().encode("utf8").strip()

    homepageEle = soup.find("a", text=re.compile(u"公司网址"))
    if(homepageEle != None):
        company["homepage"] = homepageEle["href"]
    emEles = soup.select("div.co_info > p.f_12")
    if(len(emEles) > 0):
        infoStr = emEles[0].get_text().encode("utf8")
        infos = infoStr.split("|")
        # print infos[1]
        if(len(infos) > 1):
            company["city"] = infos[1]

    comNameEle = soup.find(id="fixedcmpname")
    if(comNameEle != None and comNameEle.string != None):
        comName = comNameEle.string.encode("utf8")
        company["name"] = comName

    company["kanzhun_id"] = comId
    # for nn in company:
    #     print nn + " " + company[nn]
    return company

# 列表中，取下一个元素的 text
def getNextText(eles, i):
    if(len(eles) <= i + 1):
        print "next is null"
        return ""
    return eles[i + 1].string.encode("utf8").strip()