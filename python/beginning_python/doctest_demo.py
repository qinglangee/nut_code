# encoding: utf8 #

def square(x):
	'''
	Squares a number and returns the resule.
	测试时可以用 python doctest_demo.py  或 python doctest_demo.py -v

	>>> square(2)
	4
	>>> square(3)
	9
	'''
	return x*x

if __name__ == '__main__':
	import doctest, doctest_demo
	doctest.testmod(doctest_demo)