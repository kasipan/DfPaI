import requests

url = 'http://fezz.in/whg/projects/data/tube-stops.json'


res = requests.get(url)
dataJson = res.text

with open('tubeStops.json', 'w') as f:
    f.write(dataJson)
