import json

# print("type filename.")
# filename = input()

data = json.load(open("weather.json"))
weather = data["weather"][0]["main"]
# description = data["weather"]["description"]
temp = data["main"]["temp"] - 272.15
print("weather is "+weather)
print("temperature is "+str(temp))

print("the temperature in {} is {}".format(data["name"], temp) )
