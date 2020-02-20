import sys
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

        self.setGeometry(300, 300, 220, 160)
        self.setWindowTitle('Slider Value')

        layout = QVBoxLayout()

        self.slider = QSlider(Qt.Horizontal)
        self.slider.setFocusPolicy(Qt.StrongFocus)
        self.slider.setTickPosition(QSlider.TicksBothSides)
        self.slider.setTickInterval(10)
        self.slider.setSingleStep(1)
        self.slider.setRange(0, 99)
        self.slider.valueChanged.connect(self.newvalue)
        layout.addWidget(self.slider)

        self.le = QLineEdit("0")
        layout.addWidget(self.le)

        self.setLayout(layout)

        self.show()

    def newvalue(self):
        value = self.slider.value()
        self.le.setText(str(value))
        dig0 = int(value % 10)
        dig1 = int((value-dig0)/10)
        self.serWrite(0, dig1*16+dig0)

    def serOpen(self):
        serialPort = self.getPort()
        self.ser = serial.Serial(serialPort, 115200, timeout=0.1)

    def serWrite(self, reg, value):
        reg = reg & 7
        value = value & 255
        self.ser.write(b'S%1X%.2X\n' % (reg,value))

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
