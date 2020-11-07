
import traceback

# 测试几个输入出
def test001():
    a = hex(16)
    print(a)
    b = int(a, 16)
    print(b)
    c = int('0x2713', 16)
    print(c)
    d = hex(10003)
    print(d)
    print(chr(c))

    print(chr(c) == '✓')
    print(u'\u2713')


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


# 查找一些特殊字符所在的范围
def searchRange():
    str=""
    for i in range(100):
        like = False
        start = i * 100
        for j in range(100):
            k = i * 100 + j;
            ch = chr(k)
            if(ch == 'ᵃ'):
                like = True
            if(ch == 'ᵒ'):
                like = True
            if(ch == 'ᵘ'):
                like = True
            if(ch == 'ʷ'):
                like = True
            str += ch
        str += "\n"
        if(like):
            print(start, end=' ')
            print(str)
        str = ""

# 输出所有的 unicode 到文件中
def printAllUnicode():
    filename = "d:\\temp\\d3\\test_unicode.txt"
    writeFile(filename, "")
    line = ""
    count = 100
    for i in range(1000):
        start = i * count
        for j in range(count):
            k = i * count + j;
            try:
                ch = chr(k)
                line += str(ch)
            except Exception as e:
                # format_err = traceback.format_exc(e)
                # print("================err", format_err)
                # print("================ xxxxxxxxxxxxxxxend")
                print("==========err:", str(e))
        line += "\n"
        line = str(i) + ": " + line
        print(line)
        appendContent(filename, line)
        line = ""




if __name__ =='__main__':
    printAllUnicode()