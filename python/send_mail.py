
# https://blog.csdn.net/LeoPhilo/article/details/89074232

# smtplib 用于邮件的发信动作
import smtplib
from email.mime.text import MIMEText
# email 用于构建邮件内容
from email.header import Header
# 用于构建邮件头
 
# 发信方的信息：发信邮箱，QQ 邮箱授权码
from_addr = 'xxx@qq.com'
password = '你的授权码数字'
 
# 收信方邮箱
to_addr = 'xxx@qq.com'
 
# 发信服务器
smtp_server = 'smtp.qq.com'
 
# 邮箱正文内容，第一个参数为内容，第二个参数为格式(plain 为纯文本)，第三个参数为编码
msg = MIMEText('send by python','plain','utf-8')
 
# 邮件头信息
msg['From'] = Header(from_addr)
msg['To'] = Header(to_addr)
msg['Subject'] = Header('python test')
 
# 开启发信服务，这里使用的是加密传输
# server = smtplib.SMTP_SSL() # python 2.7 的不需要
server = smtplib.SMTP_SSL(smtp_server)  # python 3.7 需要在这加地址
server.connect(smtp_server,465)
# 登录发信邮箱
server.login(from_addr, password)
# 发送邮件
server.sendmail(from_addr, to_addr, msg.as_string())
# 关闭服务器
server.quit()
————————————————
版权声明：本文为CSDN博主「LeoPhilo」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/LeoPhilo/article/details/89074232