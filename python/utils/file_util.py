
#######################################################
# 'r'：读
# 'w'：写
# 'a'：追加
# 'r+' == r+w（可读可写，文件若不存在就报错(IOError)）
# 'w+' == w+r（可读可写，文件若不存在就创建）
# 'a+' == a+r（可追加可写，文件若不存在就创建）
# 对应的，如果是二进制文件，就都加一个b就好啦：
# 'rb'　　'wb'　　'ab'　　'rb+'　　'wb+'　　'ab+'
#######################################################


# 逐行处理文件， fun 是传入的处理函数
# 比较省内存，处理特大文件用
def processFile(filename, fun=None, stripLine=False, encoding='utf-8'):
    file = open(filename, 'r', encoding=encoding) 
    while 1:
        line = file.readline() # line 是带换行符的
        if(stripLine):
            line = line.strip("\n")
        if not line:
            break
        if(fun != None):
            fun(line)
    file.close()

# 另一种逐行读入的处理方法
def processLine(filename, encoding='utf-8'):
    file = open(filename, 'r', encoding=encoding) 
    for line in file:
        pass # do something
    file.close()

# 按行读取并返回处理后的对象列表
# fun 是对行进行处理的函数
def readAndProcess(filename, fun, skipNone=True, encoding='utf-8'):
    result = []
    file = open(filename, 'r', encoding=encoding)
    lines = file.readlines()
    for line in lines:
        line = line.strip('\n')
        item = fun(line)
        if skipNone and item == None:
            pass
        else:
            result.append(item)
    return result


# 返回文件所有行的列表，去掉换行符
def readLines(filename, encoding='utf-8'):
    result = []
    file = open(filename, 'r', encoding=encoding) 
    lines = file.readlines()
    for line in lines:
        result.append(line.strip('\n'))

    file.close()
    return result

# 返回文件内容的字符串
def readFile(filename, encoding='utf-8'):
    file = open(filename, 'r', encoding=encoding)
    content = file.read()
    return content

# 写入文件内容。覆盖
def writeFile(filename, content, encoding='utf-8'):
    file_object = open(filename, 'w', encoding=encoding)
    file_object.write(content)
    file_object.close()

# 追加文件内容
def appendContent(filename, content, encoding='utf-8'):
    file_object = open(filename, 'a', encoding=encoding)
    file_object.write(content)
    file_object.close()

# 追加文件内容，文件不存在就创建
def appendFile(filename, content, encoding='utf-8'):
    file_object = open(filename, 'a+', encoding=encoding)
    file_object.write(content)
    file_object.close()

# 列表内容写入文件。覆盖
def writeList(filename, list, toString=None, encoding='utf-8'):
    content = getListContent(list, toString)
    writeFile(filename, content, encoding=encoding)

# 列表内容转换为字符串
def getListContent(list, toString=None):
    content = ""
    for item in list:
        content = content + (toString(item) if toString != None else str(item)) + "\n"
    return content
# 列表内容写入文件。 追加 
def appendList(filename, list, toString=None, encoding='utf-8'):
    content = getListContent(list, toString)
    appendFile(filename, content, encoding=encoding)


