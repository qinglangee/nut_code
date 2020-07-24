# 读文件的内容

#  Python按行读取文件  https://www.cnblogs.com/stono/p/9095063.html

# 学习了：https://www.cnblogs.com/scse11061160/p/5605190.html
def readLine01:
    file = open("sample.txt") 
    for line in file:
        print(line)
    file.close()

 

#学习了：https://blog.csdn.net/ysdaniel/article/details/7970883
#去除换行符
def readLine02:
    for line in file.readlines():  
         line=line.strip('\n')  

 

#学习了：https://www.cnblogs.com/feiyueNotes/p/7897064.html
def readLine03:
    mobile = Method.createPhone()
    file = r'D:\test.txt'
    with open(file, 'a+') as f:
         f.write(mobile+'\n')   #加\n换行显示

