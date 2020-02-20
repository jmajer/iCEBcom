import serial
import time

try:
    ser = serial.Serial("/dev/tty.usbserial-ibSn7sY31", 115200, timeout=0.5)
except:
    print("Could not open serial port")
    exit()

delay = 0.1
while True:
    ser.write(b'S010\n')
    time.sleep(delay)
    ser.write(b'S012\n')
    time.sleep(delay)
    ser.write(b'S002\n')
    time.sleep(delay)
    ser.write(b'S00A\n')
    time.sleep(delay)
    ser.write(b'S008\n')
    time.sleep(delay)
    ser.write(b'S00C\n')
    time.sleep(delay)
    ser.write(b'S004\n')
    time.sleep(delay)
    ser.write(b'S014\n')
    time.sleep(delay)
