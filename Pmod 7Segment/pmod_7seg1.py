import sys
import serial
import serial.tools.list_ports
from PyQt5.QtWidgets import QWidget, QMessageBox, QCheckBox, QPushButton, QApplication
from PyQt5.QtCore import Qt

class Example(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.serOpen()

        self.setGeometry(300, 300, 190, 150)
        self.setWindowTitle('7Segment Control')

        styh = "QCheckBox::indicator {width: 42px; height:  8px; border-radius: 3px;} QCheckBox::indicator:checked { background-color: red;   border: 1px solid black;} QCheckBox::indicator:unchecked { background-color: #5c5c5c; border: 1px solid black;}"
        styv = "QCheckBox::indicator {width:  8px; height: 42px; border-radius: 3px;} QCheckBox::indicator:checked { background-color: red;   border: 1px solid black;} QCheckBox::indicator:unchecked { background-color: #5c5c5c; border: 1px solid black;}"

        self.cb1a = QCheckBox('', self)
        self.cb1a.move(26, 20)
        self.cb1a.setStyleSheet(styh)
        self.cb1a.stateChanged.connect(self.set7seg)

        self.cb1b = QCheckBox('', self)
        self.cb1b.move(68, 28)
        self.cb1b.setStyleSheet(styv)
        self.cb1b.stateChanged.connect(self.set7seg)

        self.cb1c = QCheckBox('', self)
        self.cb1c.move(68, 28+51)
        self.cb1c.setStyleSheet(styv)
        self.cb1c.stateChanged.connect(self.set7seg)

        self.cb1d = QCheckBox('', self)
        self.cb1d.move(26, 20+51+51)
        self.cb1d.setStyleSheet(styh)
        self.cb1d.stateChanged.connect(self.set7seg)

        self.cb1e = QCheckBox('', self)
        self.cb1e.move(20, 28+51)
        self.cb1e.setStyleSheet(styv)
        self.cb1e.stateChanged.connect(self.set7seg)

        self.cb1f = QCheckBox('', self)
        self.cb1f.move(20, 28)
        self.cb1f.setStyleSheet(styv)
        self.cb1f.stateChanged.connect(self.set7seg)

        self.cb1g = QCheckBox('', self)
        self.cb1g.move(26, 20+51)
        self.cb1g.setStyleSheet(styh)
        self.cb1g.stateChanged.connect(self.set7seg)


        self.cb2a = QCheckBox('', self)
        self.cb2a.move(26+86, 20)
        self.cb2a.setStyleSheet(styh)
        self.cb2a.stateChanged.connect(self.set7seg)

        self.cb2b = QCheckBox('', self)
        self.cb2b.move(68+86, 28)
        self.cb2b.setStyleSheet(styv)
        self.cb2b.stateChanged.connect(self.set7seg)

        self.cb2c = QCheckBox('', self)
        self.cb2c.move(68+86, 28+51)
        self.cb2c.setStyleSheet(styv)
        self.cb2c.stateChanged.connect(self.set7seg)

        self.cb2d = QCheckBox('', self)
        self.cb2d.move(26+86, 20+51+51)
        self.cb2d.setStyleSheet(styh)
        self.cb2d.stateChanged.connect(self.set7seg)

        self.cb2e = QCheckBox('', self)
        self.cb2e.move(20+86, 28+51)
        self.cb2e.setStyleSheet(styv)
        self.cb2e.stateChanged.connect(self.set7seg)

        self.cb2f = QCheckBox('', self)
        self.cb2f.move(20+86, 28)
        self.cb2f.setStyleSheet(styv)
        self.cb2f.stateChanged.connect(self.set7seg)

        self.cb2g = QCheckBox('', self)
        self.cb2g.move(26+86, 20+51)
        self.cb2g.setStyleSheet(styh)
        self.cb2g.stateChanged.connect(self.set7seg)

        self.show()


    def set7seg(self):
        val = 0
        if self.cb1a.isChecked():
            val += 1
        if self.cb1b.isChecked():
            val += 2
        if self.cb1c.isChecked():
            val += 4
        if self.cb1d.isChecked():
            val += 8
        if self.cb1e.isChecked():
            val += 16
        if self.cb1f.isChecked():
            val += 32
        if self.cb1g.isChecked():
            val += 64
        self.serWrite(1, val)
        val = 0
        if self.cb2a.isChecked():
            val += 1
        if self.cb2b.isChecked():
            val += 2
        if self.cb2c.isChecked():
            val += 4
        if self.cb2d.isChecked():
            val += 8
        if self.cb2e.isChecked():
            val += 16
        if self.cb2f.isChecked():
            val += 32
        if self.cb2g.isChecked():
            val += 64
        self.serWrite(0, val)

    def serOpen(self):
        serialPort = self.getPort()
        self.ser = serial.Serial(serialPort, 115200, timeout=0.1)

    def serWrite(self, reg, value):
        reg = reg & 7
        value = value & 255
        self.ser.write(b'S%1X%.2X\n' % (reg,value))

    def serRead(self):
        answ = self.ser.readline()
        return answ

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
