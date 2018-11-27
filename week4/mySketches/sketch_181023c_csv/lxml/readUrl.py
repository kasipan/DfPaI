import requests
from lxml import etree

urls = {
    "https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_A–B",
    "https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_C–F",
    "https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_G-K",
    "https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_L–N",
    "https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_O%E2%80%93Q",
    "https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_R%E2%80%93S",
    "https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_T%E2%80%93Z"
}

parser = etree.HTMLParser()

def get_data(url):
    res = requests.get(url)
    tree = etree.fromstring(res.text, parser)
    data = []

    data={
        "coords" : [],
        "dias" : []
    }
    data['coords'] = tree.xpath('//span[@class="geo"]/text()')
    data['dias'] = tree.xpath('//tbody[1]/tr/td[3]/text()')

    return data


all_coords = []
all_dias = []
for url in urls:
    data = get_data(url)
    print(data)
    all_coords += data['coords']
    print('added {} coords'.format(len(data['coords'])))
    all_dias += data['dias']
    print('added {} dias'.format(len(data['dias'])))


print('total of {} in coords'.format(len(all_coords)))
print('total of {} in dias'.format(len(all_dias)))

with open('moon_crater_coords_data.csv', 'w') as f:
    f.write('lat,lon,dia\n')
    for i in range( len(all_coords) ):
        lat, lon = all_coords[i].split('; ')
        f.write('{},{},'.format(lat, lon))
        f.write('{}\n'.format(all_dias[i]))
