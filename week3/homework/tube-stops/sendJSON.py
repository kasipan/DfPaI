#  osc client
from pythonosc import udp_client
from pythonosc.osc_message_builder import OscMessageBuilder

import json

ip, port = '127.0.0.1', 5000

client = udp_client.SimpleUDPClient(ip, port)


with open('tubeStops.json', 'r') as f:
    json_dict = json.loads(f.read())    # read and convert to dictionary



#lines = {}      # Set a dictionary for lines {"name":xxxx, "stops":{1:"station1", 2:"station2" ... }}
lines = []
colorIndex = {
    'District': '#007a33',
    'Piccadilly': '#10069f',
    'London Overground': '#e87722',
    'Metropolitan': '#840b55',
    'Hammersmith & City': '#e89cae',
    'Northern': '#444444',
    'Bakerloo': '#a45a2a',
    'Jubilee': '#7c878e',
    'Central': '#da291c',
    'Waterloo & City': '#6eceb2',
    'Circle': '#ffcd00',
    'Victoria': '#00a3e0',
    'East London': '#ffa300',
    'Thameslink': '#002A68',
    'Northern City': '#ff0000',
    'Hammersmith and City': '#e89cae',
    'Others': '#cccccc'
}       # it's so terrible way...

def updateLines(lineName):
    if not lineName in lines:
        lines.append(lineName)

        msg = OscMessageBuilder(address='/tubeLines')
        msg.add_arg(lineName)

        #color
        if lineName in colorIndex:
            color = colorIndex[lineName]
        else:
            color = colorIndex['Others']
        msg.add_arg(color)

        m = msg.build()
        client.send(m)
        print('sent a new line: {} ({})'. format(lineName, color))


for stop in json_dict:
    for lineName in json_dict[stop]['lines']:
        updateLines(lineName)
    client.send_message("/tubeStops", json.dumps( json_dict[stop] ))     # format into string for sending
    #print('sent {}'. format(json_dict[stop]))

        # add a stop in lines
#         lines[lineName]['stops'].append(json_dict[stop])
#         # lines[lineName]['stops'][stop] = json_dict[stop]
#         print('added {} in {}'. format(stop, lineName) )
#
# print(lines)


# it's tooooo long and refused by java!!😂
# for l in lines:
#    client.send_message("/tubeStops", json.dumps(lines[l]))     # format into string
#    print(json.dumps(lines[l]))
