import requests
from lxml import etree

urls = [
    'https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_A%E2%80%93B',
    'https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_C%E2%80%93F',
    'https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_G%E2%80%93K',
    'https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_O%E2%80%93Q',
    'https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_R%E2%80%93S',
    'https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_T%E2%80%93Z',
    'https://en.wikipedia.org/wiki/List_of_craters_on_the_Moon:_L%E2%80%93N'
]

parser = etree.HTMLParser()

def get_coords(url):
    res = requests.get(url)
    tree = etree.fromstring(res.text, parser)

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
    data = get_coords(url)
    print(data)
    all_coords += data['coords']
    print('added {} coords'.format(len(data['coords'])))
    all_dias += data['dias']
    print('added {} dias'.format(len(data['dias'])))

print('total of {} in coords'.format(len(all_coords)))
print('total of {} in dias'.format(len(all_dias)))

with open('./data/moon_crater_coords.csv', 'w') as f:
    f.write('lat,lon,dia\n')
    for i in range( len(all_coords) ):
        lat, lon = all_coords[i].split('; ')
        f.write('{},{},'.format(lat, lon))
        f.write('{}\n'.format(all_dias[i]))
