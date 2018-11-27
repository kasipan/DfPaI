#  osc client
from pythonosc import udp_client

ip, port = '127.0.0.1', 5000

client = udp_client.SimpleUDPClient(ip, port)


with open('tubeStops.json', 'r') as f:
    data = f.read()     # too long

client.send_message("/tubeStops", data)
print('sent')
