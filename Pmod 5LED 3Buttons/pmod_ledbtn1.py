import sys
import time
import serial
import serial.tools.list_ports
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *

class Example(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.serOpen()
        self.serWrite(0, 1)

        self.setGeometry(300, 300, 200, 270)
        self.setWindowTitle('Pmod Control')

        styg = "QCheckBox::indicator {width: 14px; height: 14px; border-radius: 8px;} QCheckBox::indicator:checked { background-color: lime;  border: 1px solid black;} QCheckBox::indicator:unchecked { background-color: #165c00; border: 1px solid black;}"
        styr = "QCheckBox::indicator {width: 14px; height: 14px; border-radius: 8px;} QCheckBox::indicator:checked { background-color: red;   border: 1px solid black;} QCheckBox::indicator:unchecked { background-color: #5c0000; border: 1px solid black;}"
        styw = "QCheckBox::indicator {width: 14px; height: 14px; border-radius: 8px;} QCheckBox::indicator:checked { background-color: white; border: 1px solid black;} QCheckBox::indicator:unchecked { background-color: #5c5c5c; border: 1px solid black;}"

        self.cb1 = QCheckBox(' LED 1', self)
        self.cb1.move(20, 20)
        self.cb1.toggle()
        self.cb1.stateChanged.connect(self.setLEDs)
        self.cb1.setStyleSheet(styr)

        self.cb2 = QCheckBox(' LED 2', self)
        self.cb2.move(20, 50)
        self.cb2.stateChanged.connect(self.setLEDs)
        self.cb2.setStyleSheet(styg)

        self.cb3 = QCheckBox(' LED 3', self)
        self.cb3.move(20, 80)
        self.cb3.stateChanged.connect(self.setLEDs)
        self.cb3.setStyleSheet(styg)

        self.cb4 = QCheckBox(' LED 4', self)
        self.cb4.move(20, 110)
        self.cb4.stateChanged.connect(self.setLEDs)
        self.cb4.setStyleSheet(styg)

        self.cb5 = QCheckBox(' LED 5', self)
        self.cb5.move(20, 140)
        self.cb5.stateChanged.connect(self.setLEDs)
        self.cb5.setStyleSheet(styg)

        self.cb6 = QCheckBox(' Button 1', self)
        self.cb6.move(20, 170)
        self.cb6.setDisabled(True)
        self.cb6.setStyleSheet(styw)

        self.cb7 = QCheckBox(' Button 2', self)
        self.cb7.move(20, 200)
        self.cb7.setDisabled(True)
        self.cb7.setStyleSheet(styw)

        self.cb8 = QCheckBox(' Button 3', self)
        self.cb8.move(20, 230)
        self.cb8.setDisabled(True)
        self.cb8.setStyleSheet(styw)

        self.timer = QTimer(self)
        self.timer.timeout.connect(self.updateButtons)
        self.timer.start(200)

        self.show()

    def setLEDs(self):
        val = 0
        if self.cb1.isChecked():
            val += 1
        if self.cb2.isChecked():
            val += 2
        if self.cb3.isChecked():
            val += 4
        if self.cb4.isChecked():
            val += 8
        if self.cb5.isChecked():
            val += 16
        self.serWrite(0, val)

    def updateButtons(self):
        reg, val = self.serRead()
        if (val & 1)>0:
            self.cb6.setChecked(True)
        else:
            self.cb6.setChecked(False)
        if (val & 2)>0:
            self.cb7.setChecked(True)
        else:
            self.cb7.setChecked(False)
        if (val & 4)>0:
            self.cb8.setChecked(True)
        else:
            self.cb8.setChecked(False)

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
    ex = Example()

    sys.exit(app.exec_())
