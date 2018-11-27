import requests
#import json

url = 'http://text-processing.com/api/sentiment/'

prm = {
    'text': 'Japanese',
}

res = requests.post(url, data={'text':'japanese'})

#data = json.loads(res.text)
data = res.json()

print(data)
# temp = data["main"]["temp"] - 272.15
# site = data["name"]
#
# print('Temperature in {} is {}'.format(data["name"], temp))
