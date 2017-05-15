# coding utf8
from bs4 import BeautifulSoup
def echo(content):
	if(not content is None):
		print content.encode('gbk')

liepin_src = open('beautiful_soup_src_liepin.html')
try:
    text = unicode(liepin_src.read(),'u8')
finally:
    liepin_src.close()
# print text
doc = BeautifulSoup(text, "html.parser")
echo(doc.title)
# print doc.prettify().encode('gbk')

for link in doc.find_all('a'):
	item_h3 = link.find('h3')
	item_title = None
	if(not item_h3 is None):
		item_title = item_h3.find("span")
	if(not item_title is None):
		echo(item_title.get_text())