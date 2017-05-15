def add(a,b):
    return a+b
def writeFile(filename, content):
    file_object = open(filename, 'w')
    file_object.write(content)
    file_object.close()

def readFile(filename):
    file = open(filename)
    content = file.read()
    file.close
    return content

def nouse():
    return 0