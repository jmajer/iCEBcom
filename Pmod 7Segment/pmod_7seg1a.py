import time
import serial
import serial.tools.list_ports

iCEBreakerPorts = [
    p.device
    for p in serial.tools.list_ports.comports()
    if 'iCEBreaker' in p.description
]
if len(iCEBreakerPorts)>0:
    iCEBreakerPorts.sort()
    serialPort = iCEBreakerPorts[-1]
else:
    raise IOError('Could not find iCEBreaker')

ser = serial.Serial(serialPort, 115200, timeout=0.1)

delay = 0.5
while True:
    ser.write(b'S100\n')    # ' '
    ser.write(b'S076\n')    # 'H'
    time.sleep(delay)
    ser.write(b'S176\n')    # 'H'
    ser.write(b'S079\n')    # 'E'
    time.sleep(delay)
    ser.write(b'S179\n')    # 'E'
    ser.write(b'S038\n')    # 'L'
    time.sleep(delay)
    ser.write(b'S138\n')    # 'L'
    ser.write(b'S038\n')    # 'L'
    time.sleep(delay)
    ser.write(b'S138\n')    # 'L'
    ser.write(b'S03F\n')    # 'O'
    time.sleep(delay)
    ser.write(b'S13F\n')    # 'O'
    ser.write(b'S000\n')    # ' '
    time.sleep(delay)
    ser.write(b'S100\n')    # ' '
    ser.write(b'S000\n')    # ' '
    time.sleep(delay)
    ser.write(b'S100\n')    # ' '
    ser.write(b'S07E\n')    # 'W'
    time.sleep(delay)
    ser.write(b'S17E\n')    # 'W'
    ser.write(b'S05C\n')    # 'o'
    time.sleep(delay)
    ser.write(b'S15C\n')    # 'o'
    ser.write(b'S050\n')    # 'r'
    time.sleep(delay)
    ser.write(b'S150\n')    # 'r'
    ser.write(b'S006\n')    # 'l'
    time.sleep(delay)
    ser.write(b'S106\n')    # 'l'
    ser.write(b'S05E\n')    # 'd'
    time.sleep(delay)
    ser.write(b'S15E\n')    # 'd'
    ser.write(b'S000\n')    # ' '
    time.sleep(delay)
    ser.write(b'S100\n')    # ' '
    ser.write(b'S000\n')    # ' '
    time.sleep(delay)
