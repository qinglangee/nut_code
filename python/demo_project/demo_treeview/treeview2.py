# -*- coding: utf-8 -*-
"""
Created on Fri Jan  4 13:44:40 2019
@author: HJY
"""

# https://blog.csdn.net/yeshankuangrenaaaaa/article/details/86085705

 
import tkinter as tk
from tkinter import ttk
import re
import time
 
#固定
pattern = '{"排名": "(.*?)", "片名": "(.*?)", "主演": "(.*?)", "上映时间": "(.*?)", "评分": "(.*?)"}\n'
patch = re.compile(pattern)
 
class info():
    def __init__(self,):
        self.root = tk.Tk()
        self._setpage()
               
    def _setpage(self,):
        start= time.time()
        
        self.scrollbar = tk.Scrollbar(self.root,)
        self.scrollbar.pack(side=tk.RIGHT,fill=tk.Y)
           
        title=['1','2','3','4','5',]
        self.box = ttk.Treeview(self.root,columns=title,
                                yscrollcommand=self.scrollbar.set,
                                show='headings')
        
        self.box.column('1',width=50,anchor='center')
        self.box.column('2',width=200,anchor='center')
        self.box.column('3',width=300,anchor='center')
        self.box.column('4',width=150,anchor='center')
        self.box.column('5',width=50,anchor='center')
        
        self.box.heading('1',text='Range')
        self.box.heading('2',text='Flim Name')
        self.box.heading('3',text='Actor')
        self.box.heading('4',text='Time')
        self.box.heading('5',text='Score')
        
        self.dealline()
                
        self.scrollbar.config(command=self.box.yview)
        self.box.pack()
 
        end=time.time()
        tk.Label(self.root,text=end-start,fg='red').pack()
        tk.Button(self.root,text='Look',bg='green',).pack()
                
    def readdata(self,):    
        """逐行读取文件"""    
        
        #读取gbk编码文件，需要加encoding='utf-8'
        f = open('result2.txt','r',encoding='utf-8')
        line = f.readline()
        while line:
            yield line
            line = f.readline()  
        f.close()
        
    def dealline(self,):
        op = self.readdata()
        while 1:
            try:
                line = next(op)
            except StopIteration as e:
                break
            else:
                result = patch.match(line)
                if(result != None):
                    self.box.insert('','end',values=[result.group(i) for i in range(1,6)])
                                
             
if __name__ == '__main__':
    op = info()
    op.root.mainloop()