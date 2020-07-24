import inspect

import Foo
import utils
#from importlib import import_module
from utils import *
#from utils import Util01 

#import_module('utils')

addon_classes =[]
except_modules=['os']

def extractClasses(modelName):
	for name, obj in inspect.getmembers(modelName):
	    if inspect.isclass(obj):
	        addon_classes.append(obj)

def extractModule(argName):
	for name, obj in inspect.getmembers(argName):
	    if inspect.ismodule(obj):
	    	if not name in except_modules:
	    		extractClasses(obj)

extractModule(utils)
#inspectAny(Util01)


for clazz in addon_classes:
	print(clazz)