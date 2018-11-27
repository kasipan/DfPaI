import requests
#import json

url = 'http://api.openweathermap.org/data/2.5/weather'

prm = {
    'q': 'sapporo',
    'appid': '0e1b4e0d575c26e9ea3ed59d3f8f9538'
}

res = requests.get(url, params=prm)

#print(res.text)

#data = json.loads(res.text)
data = res.json()

temp = data["main"]["temp"] - 272.15
site = data["name"]

print('Temperature in {} is {}'.format(data["name"], temp))
