#!/usr/bin/python

import serial
import time 
import struct 

ser = serial.Serial('/dev/ttyUSB0')  # open serial port
print(ser.name)         # check which port was reall

oe = 0
avg = 0
while ser.is_open:
    line = ser.readline()
    try:
        n = struct.unpack('i', line[2:-4])[0]
        e = int(time.time())
        if oe > 0:
            d = e - oe
            avg = 500000.0/d
            avg = avg * 2
        oe = e

        print(str(e) + " -> " + str(n) + " Avg: " + str(avg))
    except:
        pass
