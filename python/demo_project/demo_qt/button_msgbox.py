#!/usr/bin/python

"""
ZetCode PyQt5 tutorial

This example shows a tooltip on
a window and a button.

Author: Jan Bodnar
Website: zetcode.com
"""

import sys
from PyQt5.QtWidgets import (QWidget, QToolTip,
    QPushButton, QApplication, QMessageBox, QDesktopWidget)
from PyQt5.QtGui import QFont


class Example(QWidget):

    def __init__(self):
        super().__init__()

        self.initUI()


    def initUI(self):

        QToolTip.setFont(QFont('SansSerif', 10))

        self.setToolTip('This is a <b>QWidget</b> widget')

        # 创建按钮
        btn = QPushButton('Button', self)
        btn.clicked.connect(QApplication.instance().quit)
        # 按钮加提示文字
        btn.setToolTip('This is a <b>QPushButton</b> widget')
        btn.resize(btn.sizeHint())
        # 设置位置
        btn.move(50, 50)

        self.resize(300, 200)
        self.center()
        self.setWindowTitle('Tooltips')
        self.show()

    # 覆盖 closeEvent() 事件处理函数
    def closeEvent(self, event):

        reply = QMessageBox.question(self, 'Message',
                                     "Are you sure to quit?", QMessageBox.Yes |
                                     QMessageBox.No, QMessageBox.No)

        if reply == QMessageBox.Yes:
            event.accept()
        else:
            event.ignore()

    # 把窗口居中
    def center(self):

        # 返回一个表示主窗口形状的矩形。
        qr = self.frameGeometry()
        # QDesktopWidget 类提供用户桌面的信息，包括屏幕大小
        # 得到屏幕的中心点
        cp = QDesktopWidget().availableGeometry().center()
        # 把矩形的中心移到屏幕的中心
        qr.moveCenter(cp)
        # 然后把窗口移到矩形的左上角
        self.move(qr.topLeft())

def main():

    app = QApplication(sys.argv)
    ex = Example()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()