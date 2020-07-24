

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