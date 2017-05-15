# -*- coding:utf-8 -*-
import time
import re

import requests

from pyquery import PyQuery as pq
from gevent import monkey
from gevent.pool import Pool

monkey.patch_socket()

local_ip = ""


def ignore_exception(fn):
    def _(*args, **kwargs):
        try:
            return fn(*args, **kwargs)
        except:
            return None
    return _


@ignore_exception
def get_ip_by_baidu(proxies=None):
    baidu = requests.get(
        'http://m.baidu.com/s?word=ip',
        proxies=proxies, timeout=5, headers={'user-agent': 'chrome', })

    p = re.compile(r'IP:.+?<span.+?>(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})</span>', re.DOTALL)
    m = p.findall(baidu.text)
    if m:
        return m[0]

def get_local_ip():
    ip = get_ip_by_baidu()
    print 'local ip = ', ip
    return ip


def valid_proxy(ip, port):

    proxies = {'http': 'http://%s:%s' %
               (ip, port), 'https': 'https://%s:%s' % (ip, port)}
    time_start = time.time()
    ip = get_ip_by_baidu(proxies)
    time_cost = time.time() - time_start
    if (ip != None and ip != local_ip):
        return ip, port, time_cost
    else:
        return ip, port, None


def valid_proxies(ip_list):
    print 'validing ip_list ...',len(ip_list)

    threads = []
    valid_proxy_list = []
    p = Pool(1024)

    for ip in ip_list:
        if not ip:
            continue
        url = '%s:%s' % (ip.get('ip'), ip.get('port'))
        threads.append(p.spawn(valid_proxy, ip.get('ip'), ip.get('port')))

    for thread in threads:
        ip, port, time_cost = thread.get()
        if time_cost:
            valid_proxy_list.append(
                {'ip': ip, 'port': port, 'time': time_cost})

    print 'valided ip_list', len(valid_proxy_list)
    return valid_proxy_list


@ignore_exception
def fetch_kuaidaili():
    ip_list = []
    for i in range(1, 11):
        r = pq(url="http://www.kuaidaili.com/proxylist/%s" % i)
        trs = r('tbody').find('tr')
        ip_list.extend([{'ip': tds.eq(0).text(), 'port': tds.eq(1).text()}
                       for tds in [tr('td') for tr in trs.items()]])
    return ip_list


@ignore_exception
def fetch_cn_proxy_com():
    h = requests.get("http://cn-proxy.com/", timeout=10)
    r = pq(h.text)
    trs = r('tbody').find('tr')
    return [{'ip': tds.eq(0).text(), 'port': tds.eq(1).text()} for tds in [tr('td') for tr in trs.items()]]


@ignore_exception
def fetch_xici():
    listapi = []
    apis = ['http://www.xici.net.co/qq/1','http://www.xici.net.co/wn/1','http://www.xici.net.co/nn/1']
    for api in apis:
        r = requests.get(api, timeout=10)
        p = re.compile(
            r'<td>(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})</td>\s+<td>(\d+)</td>')
        m = p.findall(r.text)
        listapi.extend([{'ip': ip[0], 'port': ip[1]} for ip in m])
    return listapi

def fetch_pachong():
    urls = [
        # 'http://pachong.org/',
        # 'http://pachong.org/area/short/name/.html',
        # 'http://pachong.org/anonymous.html',
        # 'http://pachong.org/area/short/name/us.html',
        # 'http://pachong.org/area/short/name/ca.html',
        # 'http://pachong.org/area/short/name/cn.html',
        # 'http://pachong.org/area/short/name/in.html',
        # 'http://pachong.org/area/short/name/jp.html',
        # 'http://pachong.org/area/short/name/kr.html',
        'http://pachong.org/high.html',
        'http://pachong.org/area/short/name/de.html'
    ]
    dlist = []
    for url in urls:
        r = requests.get(url,timeout=10)
        if r.status_code == 200:
            text = r.text
            reg = r'var [a-z]+=.+;'
            p = re.compile(reg)
            match = p.findall(text)
            vars = ''
            if match:
                vars = match.pop(0)
            if vars == '':
                return
            vs = vars.split(';')
            extra = {}
            index = 0
            for v in vs:
                dv = v[len('var '):]
                dvs = dv.split('=')
                if len(dvs) < 2:
                    continue
                key = dvs[0]
                ds = dvs[1]
                da = ds.split('+')
                value = 0
                if index == 0:
                    value = int(da[0]) + int(da[1])
                else:

                    v1 = int(da[0])
                    v2 = da[1]
                    v2s = v2.split('^')
                    value = v1 + int(int(v2s[0]) ^ int(extra[v2s[1]]))

                index += 1
                extra[key] = value


            jquery = pq(text)
            trs = jquery('.tb tr')

            for i in range(1,len(trs)):
                tr = trs[i]
                jtr = pq(tr)
                tds = jtr('td')
                host = ''
                port = 0
                for i in range(0,len(tds)):
                    if i == 1:
                        jtd = pq(tds[i])
                        host = jtd.text()
                    elif i == 2:
                        jtd = pq(tds[i])
                        scri = jtd.text()
                        ds = scri[scri.index('(') + 1:len(scri) - 2]
                        dss = ds.split('+')

                        x1 = dss[0]
                        x2 = int(dss[1])
                        x1 = x1[1:len(x1)-1]
                        xs = x1.split('^')
                        step = int(xs[0])
                        key = xs[1]
                        value = extra[key]
                        port = int(step^value) + x2
                    if port == 0:
                        continue
                    d = {'ip':host,'port':port}
                    dlist.append(d)
                    break
    return dlist

def getYoudaili():
    url = 'http://win7sky.com/daili/20150328-2038.html'
    headers = {
        'Referer':'http://www.youdaili.net/Daili/QQ/3235.html',
        'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 Safari/537.36'
    }
    reg = '(\d+.\d+.\d+.\d+.:\d+)'
    ips = []
    rq = requests.get(url,headers=headers)

    if rq.status_code == 200:
        text = rq.text
        p = re.compile(reg)
        match = p.findall(text)
        if len(match) > 1:
            for i in range(1,len(match)):
                m = match[i]
                ms = m.split(':')
                ips.append({'ip':ms[0],'port':ms[1]})
    else:
        print str(rq.status_code)
    return ips

def getProxyRu():
    url = "http://www.proxy.com.ru/list_%d.html"
    ips = []
    reg = '<td>(\d+.\d+.\d+.\d+)</td><td>(\d+)</td>'
    for i in range(1,10):
        rq = requests.get(url%i)
        if rq.status_code == 200:
            text = rq.text
            p = re.compile(reg)
            match = p.findall(text)
            if len(match):
                for ip in match:
                    ips.append({'ip':ip[0],'port':ip[1]})
    return ips

def getProxy360():
    url = 'http://www.proxy360.cn/Region/Japan'
    headers={
        'Connection': 'Keep-Alive',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Language': 'zh-CN,zh;q=0.8,en-US;q=0.6,en;q=0.4,zh-TW;q=0.2',
        'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:35.0) Gecko/20100101 Firefox/35.0',
        'Accept-Encoding':'gzip,deflate,sdch'
    }
    rq = requests.get(url,headers=headers)
    ips = []
    if rq.status_code == 200:
        text = rq.text
        jq = pq(text)
        proxylistitems = jq(".proxylistitem")
        if len(proxylistitems) > 0:
            reg = '(\d+.\d+.\d+.\d+. \d+)'
            for proxylistitem in proxylistitems:
                pjq = pq(proxylistitem)
                tx = pjq.text()
                p = re.compile(reg)
                match = p.findall(tx)
                if len(match) > 0:
                    m = match[0].split(' ')
                    ips.append({'ip':m[0],'port':m[1]})
    return ips

def getIpDaili(id):

    mainurl = 'http://www.ip-daili.com/xw/?id=%d'%id
    mrq = requests.get(mainurl)
    href = 'http://www.ip-daili.com/view/?id=2733'
    if mrq.status_code == 200:
        text = mrq.text
        jq = pq(text)
        xw = jq('.lmy-right-xw')
        lis = xw("li")
        for i in range(0,13):
            href = 'http://www.ip-daili.com/view/?id=2733'
            li = lis[i]
            eli = pq(li)
            sas = eli('a')
            sa = sas[1]
            href = pq(sa).attr('href')
            reg = '(\d+.\d+.\d+.\d+.:\d+)'
            reg1 = '(\d+.\d+.\d+.\d+. \d+)'
            ips = []
            headers = {
                'Referer':'http://www.ip-daili.com/xw/?id=5',
                'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 Safari/537.36'
            }
            rq = requests.get(href,headers=headers)
            if rq.status_code == 200:
                text = rq.text
                p = re.compile(reg)
                match = p.findall(text)
                if len(match) > 1:
                    for i in range(1,len(match)):
                        m = match[i]
                        if m.find('-') > 0:
                            continue
                        ms = m.split(':')
                        ips.append({'ip':ms[0],'port':ms[1]})
                if len(ips) < 1:
                    p = re.compile(reg1)
                    match = p.findall(text)
                    if len(match) > 1:
                        for i in range(1,len(match)):
                            m = match[i]
                            if m.find('-') > 0:
                                continue
                            ms = m.split(' ')
                            ips.append({'ip':ms[0].rstrip('\t'),'port':ms[1]})
    return ips

def get360Doc():
    headers={
        'Connection': 'Keep-Alive',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Language': 'zh-CN,zh;q=0.8,en-US;q=0.6,en;q=0.4,zh-TW;q=0.2',
        'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:35.0) Gecko/20100101 Firefox/35.0',
        'Accept-Encoding':'gzip,deflate,sdch'
    }
    url = "http://www.qz321.net/13005.html"
    ips = []
    reg = '(\d+.\d+.\d+.\d+:\d+)'
    rq = requests.get(url,headers=headers)
    if rq.status_code == 200:
        text =rq.text
        p = re.compile(reg)
        match = p.findall(text)
        if len(match) > 0:
            for m in match:
                ms = m.split(':')
                ips.append({'ip':ms[0],'port':ms[1]})
    return ips

def getIpqz():
    mainurl = "http://www.qz321.net/ipdl/gwip/"
    reg = '(\d+.\d+.\d+.\d+:\d+)'
    rq = requests.get(mainurl)
    ips = []
    www = 'http://www.qz321.net'
    if rq.status_code == 200:
        text = rq.text
        jq = pq(text)
        ul = jq('.e1')
        lis = ul('li')
        if len(lis) < 1:
            return ips
        for li in lis:
            pqLi = pq(li)
            sas = pqLi('a')
            sa = sas[0]
            tsa = pq(sa)
            href = tsa.attr('href')
            turl = www + href
            trq = requests.get(turl)
            if trq.status_code == 200:
                tx = trq.text
                p = re.compile(reg)
                match = p.findall(tx)
                if len(match) > 0:
                    for m in match:
                        ms = m.split(':')
                        ips.append({'ip':ms[0],'port':ms[1]})
    return ips
def get66IP():
    url = 'http://proxy.com.ru/list_%d.html'
    ips = []
    headers = {
        'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 Safari/537.36'
    }
    for i in range(1,3):
        turl = url%i
        rq = requests.get(turl,headers=headers)
        if rq.status_code == 200:
            text = rq.text
            jq = pq(text)
            trText = jq.text()
            reg = '(\d+.\d+.\d+.\d+. \d+)'
            p = re.compile(reg)
            match = p.findall(trText)
            if len(match) > 0:
                for m in match:
                    ms = m.split(' ')
                    ips.append({'ip':ms[0],'port':ms[1]})
        else:
            print str(rq.status_code)
    return ips

def getMayidaili():
    url = 'http://www.mayidaili.com'
    headers = {
        'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 Safari/537.36',
        'Host':'www.mayidaili.com'
    }
    rq = requests.get(url)
    ips = []
    if rq.status_code == 200:
        text = rq.text
        jq = pq(text)
        table = jq('.table')
        atext = table.text()
        reg = '(\d+.\d+.\d+.\d+)'
        treg = '(\d+ \d+)'
        p = re.compile(reg)
        tp = re.compile(treg)
        match = p.findall(atext)
        if len(match) > 0:
            index = 0
            for i in range(0,len(match),2):
                m1 = match[i]
                m2 = match[i+1]
                ms = m2.split(' ')
                for mm in ms:
                    ips.append({'ip':m1,'port':mm})
    try:
        apiRq = requests.get('http://www.mayidaili.com/api/get_proxy_list/?tcode=free&num=200&ansl=0')
        if apiRq.status_code == 200:
            jon = apiRq.json()
            data = jon['data']
            if len(data) > 0:
                for ip in data:
                    ips.append({'ip':ip['host'],'port':ip['port']})
    except Exception, e:
        print 'request error: ' + 'http://www.mayidaili.com/api/get_proxy_list/?tcode=free&num=200&ansl=0'
    return ips

def getMesk():
    url = 'http://www.mesk.cn/ip/'
    rq = requests.get(url)
    reg = '(\d+.\d+.\d+.\d+:\d+)'
    ips = []
    if rq.status_code == 200:
        text = rq.text
        jq = pq(text)
        arclist = jq('.arclist-li')
        jqArc = pq(arclist)
        lis = jqArc('li')
        for i in range(0,3):
            li = lis[i]
            jqLi = pq(li)
            al = jqLi('.ico')
            sa = al[0]
            jqSa = pq(sa)
            href = jqSa.attr('href')
            turl = 'http://www.mesk.cn' + href
            trq = requests.get(turl)
            if trq.status_code == 200:
                text = trq.text
                jqText = pq(text)
                p = re.compile(reg)
                match = p.findall(jqText.text())
                if len(match) > 0:
                    for m in match:
                        ms = m.split(':')
                        if m.find('-') > 0:
                            continue
                        ips.append({'ip':ms[0],'port':ms[1]})
    return ips

def getIP004():
    url = 'http://ip004.com'
    rq = requests.get(url)
    ips = []
    if rq.status_code == 200:
        text = rq.text
        jq = pq(text)
        jqText = jq.text()
        reg = '(\d+.\d+.\d+.\d+. \d+)'
        p = re.compile(reg)
        match = p.findall(jqText)

        if len(match) > 0:
            for m in match:
                ms = m.split(' ')
                if m.find('-') > 0:
                    continue
                if ms[1].find('.') > 0:
                    continue
                ips.append({'ip':ms[0],'port':ms[1]})
    return ips

def fetch():
    global local_ip
    local_ip = get_local_ip()

    # fetch_methods = [fetch_cn_proxy_com, fetch_kuaidaili, fetch_xici]

    ip_list = []
    cns = fetch_cn_proxy_com()
    if cns and len(cns) > 0:
        ip_list.extend(cns)
    kus = fetch_kuaidaili()
    if kus and len(kus) > 0:
        ip_list.extend(kus)
    xis = fetch_xici()
    if xis and len(xis) > 0:
        ip_list.extend(xis)
    pc = fetch_pachong()
    ip_list.extend(pc)
    for i in range(1,5):
        ip_list.extend(getIpDaili(i))
    ip_list.extend(getMayidaili())
    ip_list.extend(getProxy360())
    return valid_proxies(ip_list)


# import random
# def main():
#     ps = fetch()
#     p = ps[random.randint(0,len(ps))]
#     print p, type(p)
#
#
if __name__ == "__main__":
    ips = getMayidaili()
    print str(ips)