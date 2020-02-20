import sys
import serial
import serial.tools.list_ports
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5.QtCore import *

class App(QWidget):

    def __init__(self):
        super().__init__()
        self.title = 'icebcom'
        self.left = 0
        self.top = 0
        self.width = 262
        self.height = 306
        self.initUI()

    def initUI(self):
        self.serOpen()

        self.setWindowTitle(self.title)
        self.setGeometry(self.left, self.top, self.width, self.height)

        self.createTable()

        # Add box layout, add table to box layout and add box layout to widget
        self.layout = QVBoxLayout()
        self.layout.addWidget(self.tableWidget)
        self.setLayout(self.layout)

        self.timer = QTimer(self)
        self.timer.timeout.connect(self.updateValue)
        self.timer.start(200)

        self.data0=[0,0,0,0,0,0,0,0]
        # Show widget
        self.show()

    def createTable(self):
       # Create table
        self.tableWidget = QTableWidget()
        self.tableWidget.setRowCount(8)
        self.tableWidget.setVerticalHeaderLabels(['0','1','2','3','4','5','6','7'])
        self.tableWidget.setColumnCount(2)
        self.tableWidget.setHorizontalHeaderLabels(['IN','OUT'])
        for y in range(8):
            self.tableWidget.setItem(y,0, QTableWidgetItem("0x00"))
            self.tableWidget.setItem(y,1, QTableWidgetItem("0xXX"))
        self.tableWidget.move(0,0)

        # table selection change
        self.tableWidget.cellChanged.connect(self.on_change)

    def on_change(self, r, c):
        cell = self.tableWidget.item(r,c).text()
        #print("changed row:%d col:%d '%s'" % (r,c,cell))
        if c==0:
            try:
                nval = int(cell,16)
                if nval<0 or nval>255:
                    nval = self.data0[r]
            except:
                nval = self.data0[r]
            ncell = "0x%.2X" % nval
            if cell != ncell:
                self.data0[r] = nval
                #print(self.data0)
                self.tableWidget.setItem(r,0, QTableWidgetItem(ncell))
                self.serWrite(r, nval)

    def updateValue(self):
        reg, value = self.serRead()
        if 0 <= reg <= 7:
            self.tableWidget.setItem(reg, 1, QTableWidgetItem("0x%.2X" % value))

    def serOpen(self):
        serialPort = self.getPort()
        self.ser = serial.Serial(serialPort, 115200, timeout=0.1)

    def serWrite(self, reg, value):
        reg = reg & 7
        value = value & 255
        self.ser.write(b'S%1X%.2X\n' % (reg,value))

    def serRead(self):
        answ = self.ser.readline()
        if len(answ)==5:
            reg = answ[1]-48
            value = int(answ[2:4],16)
            return (reg, value)
        else:
            return(-1, 0)

    def getPort(self):
        iCEBreakerPorts = [
            p.device
            for p in serial.tools.list_ports.comports()
            if 'iCEBreaker' in p.description
        ]
        if len(iCEBreakerPorts)>0:
            iCEBreakerPorts.sort()
            return iCEBreakerPorts[-1]
        else:
            raise IOError('Could not find iCEBreaker')

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = App()
    sys.exit(app.exec_())
