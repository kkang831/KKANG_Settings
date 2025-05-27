#####################################################################
# Import my own functions
import os
import sys
import types
import importlib
my_functions = os.path.join(os.environ.get('KKANG_Bin'), 'functions')
sys.path.append(my_functions)
for filename in os.listdir(my_functions):
    if filename.endswith(".py"):
        module = importlib.import_module(filename[:-3])
        funcs = {attr: getattr(module, attr) for attr in dir(module) 
                 if isinstance(getattr(module, attr), types.FunctionType)}
        globals().update(funcs)
#####################################################################