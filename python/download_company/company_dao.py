# -*- coding: utf-8 -*-
import mysql.connector
import config
import logging
import traceback

username = config.db["username"]
password = config.db["password"]
host = config.db["host"]
database = config.db["database"]


def insert(company):
    cnn = mysql.connector.connect(user='root',password='zhch',host='127.0.0.1',database='sqtzhch')
    cursor=cnn.cursor()
    try:
        
        # for key in company:
        #     logging.debug(key + " " + company[key])
        sql_insert = "insert into basedate_company (name, industry, attr,found_time,scale,homepage,address,city,description,kanzhun_id,file) values (%(name)s, %(industry)s,%(attr)s,%(found_time)s,%(scale)s,%(homepage)s,%(address)s,%(city)s,%(description)s,%(kanzhun_id)s,%(file)s)"

        if(company["found_time"] == "" or company["found_time"] == "--"):
            sql_insert = sql_insert.replace(",found_time", "")
            sql_insert = sql_insert.replace(",%(found_time)s", "")
            logging.debug("comId:" + company["kanzhun_id"] + " new sql :" + sql_insert)

        cursor.execute(sql_insert, company)
        #如果数据库引擎为Innodb，执行完成后需执行cnn.commit()进行事务提交
        cnn.commit()
    except mysql.connector.Error as e:
        exstr = traceback.format_exc()
        logging.error('comId:{} insert datas error!\n{}'.format(company["kanzhun_id"], exstr))
    finally:
        cursor.close()
        cnn.close()

