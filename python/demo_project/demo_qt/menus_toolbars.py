#!/usr/bin/python

"""
ZetCode PyQt5 tutorial

This program creates a statusbar.

Author: Jan Bodnar
Website: zetcode.com
"""

# QMainWindow 提供了带状态栏 工具栏和菜单的程序框架
import sys
from PyQt5.QtWidgets import QMainWindow, QApplication, QMenu, QAction, qApp, QTextEdit
from PyQt5.QtGui import QIcon

class Example(QMainWindow):

    def __init__(self):
        super().__init__()

        self.initUI()

    def initUI(self):
        self.status_bar = self.statusBar()

        # 创建命令
        exitAct = QAction(QIcon('exit.png'), '&Exit', self)
        exitAct.setShortcut('Ctrl+Q')
        exitAct.setStatusTip('Exit application') ## 鼠标滑过提示
        exitAct.triggered.connect(qApp.quit)

        menubar = self.menuBar()
        fileMenu = menubar.addMenu('&File')
        fileMenu.addAction(exitAct)

        # 子菜单，菜单中的菜单
        impMenu = QMenu('Import', self)
        impAct = QAction('Import mail', self)
        impMenu.addAction(impAct)

        newAct = QAction('New', self)
        fileMenu.addAction(newAct)
        fileMenu.addMenu(impMenu)

        # 可选菜单
        viewMenu = menubar.addMenu("View")

        viewStatAct = QAction('View statusbar', self, checkable= True)
        viewStatAct.setStatusTip('View statusbar')
        viewStatAct.setChecked(True)
        viewStatAct.triggered.connect(self.toggleMenu)

        viewMenu.addAction(viewStatAct)

        # 工具栏
        self.toolbar = self.addToolBar('Exit')
        self.toolbar.addAction(exitAct)

        # 编辑区域
        textEdit = QTextEdit()
        self.setCentralWidget(textEdit)




        # 状态栏显示信息
        self.statusBar().showMessage('Ready')

        self.setGeometry(300, 300, 400, 300)
        self.setWindowTitle('Menu Toolbar Statusbar')
        self.show()

    def toggleMenu(self, state):
        if state:
            self.status_bar.show()
        else:
            self.status_bar.hide()

    # 上下文菜单, 需要覆盖这个 contextMenuEvent() 方法
    def contextMenuEvent(self, event):
        cmenu = QMenu(self)

        newAct = cmenu.addAction("New")
        openAct = cmenu.addAction("Open")
        quitAct = cmenu.addAction("Quit")
        # exec_() 显示菜单， event.pos() 返回点击的坐标 
        # mapToGlobal() 把坐标转换为全局坐标
        action = cmenu.exec_(self.mapToGlobal(event.pos()))

        # 处理选中的菜单
        if action == quitAct:
            qApp.quit()


def main():
    app = QApplication(sys.argv)
    ex = Example()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()