from PIL import Image

img = Image.open("redPanda600.jpg")

#############

#pixels = list(img.getdata())
#bandw = [(p[0],p[0],p[0]) for p in pixels]
#img.putdata(bandw)

#############

for i in range(2000):
    img = img.rotate(90, expand=True)
    img.save('{}.jpg'.format(i))
    img = Image.open('{}.jpg'.format(i))
