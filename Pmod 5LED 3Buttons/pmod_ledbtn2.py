import sys
import serial
import serial.tools.list_ports
from math import exp
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *

class Example(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.serOpen()

        self.setGeometry(300, 300, 220, 160)
        self.setWindowTitle('LED PWM')

        layout = QVBoxLayout()

        self.label1 = QLabel("red")
        layout.addWidget(self.label1)

        self.slider1 = QSlider(Qt.Horizontal)
        self.slider1.setFocusPolicy(Qt.StrongFocus)
        self.slider1.setTickPosition(QSlider.TicksBothSides)
        self.slider1.setTickInterval(10)
        self.slider1.setSingleStep(1)
        self.slider1.valueChanged.connect(self.setvalue1)
        layout.addWidget(self.slider1)

        self.label2 = QLabel("green")
        layout.addWidget(self.label2)

        self.slider2 = QSlider(Qt.Horizontal)
        self.slider2.setFocusPolicy(Qt.StrongFocus)
        self.slider2.setTickPosition(QSlider.TicksBothSides)
        self.slider2.setTickInterval(10)
        self.slider2.setSingleStep(1)
        self.slider2.valueChanged.connect(self.setvalue2)
        layout.addWidget(self.slider2)

        self.rb1 = QRadioButton('linear')
        layout.addWidget(self.rb1)
        self.rb1.setChecked(True)
        self.rb1.toggled.connect(lambda:self.buttonchanged())

        self.rb2 = QRadioButton('logarithmic')
        layout.addWidget(self.rb2)

        self.setLayout(layout)

        self.show()

    def buttonchanged(self):
        self.setvalue1()
        self.setvalue2()

    def setvalue1(self):
        value = self.slider1.value()
        if self.rb1.isChecked():
            if value>0:
                nval = round(1 + (value-1)*254/98)
            else:
                nval = 0
        else:
            if value>0:
                nval = round(2**((value-1)*8/98.0692))
            else:
                nval = 0
        self.serWrite(0, nval)

    def setvalue2(self):
        value = self.slider2.value()
        if self.rb1.isChecked():
            if value>0:
                nval = round(1 + (value-1)*254/98)
            else:
                nval = 0
        else:
            if value>0:
                nval = round(2**((value-1)*8/98.0692))
            else:
                nval = 0
        self.serWrite(1, nval)

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
