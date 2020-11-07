# coding:utf-8
# 
# 运行方法　: python code.py

import web

render = web.template.render('templates/')
urls = (
    '/add', 'add',
    '/(.*)', 'hello',
)

class hello:        
    def GET(self, name):
        # if not name: 
        #     name = 'World'
        # return 'Hello, ' + name + '!'
        
        return render.index(name)
class add:        
    def GET(self):
        # if not name: 
        #     name = 'World'
        # return 'Hello, ' + name + '!'
        
        return render.index('here is add')

if __name__ == "__main__":
    app = web.application(urls, globals())
    app.run()