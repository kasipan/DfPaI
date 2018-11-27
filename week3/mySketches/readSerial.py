import Serial
port = serial.Serial('/dev/XXXXX')

while True:
    line = port.readline()
    print(line)
    ata = line.decode('utf8')
    print(data.strip())
    print('-')
