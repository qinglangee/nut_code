
conf = [{'item':{'name':'zhang','id':426}, 'prop':{'name':'pr_name'}},
{'item':{'name':'zhang','id':426},}]

for c in conf:
	print('=======' + c['item']['name'])
	if 'prop' in c and 'name' in c['prop']:
		print('has prop')
	else:
		print('no prop')