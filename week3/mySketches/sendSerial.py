import serial

post = serial.Serial("/dev/XXXXX")


while True:     #infinite loop
    msg = input()

    if msg == 'a':
        port.write(b'a')    // sending byte of 'a'
    else:
        port.write(b'b')
