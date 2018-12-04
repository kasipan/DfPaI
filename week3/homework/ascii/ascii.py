from PIL import Image

threshold = 50
img = Image.open("img.png")

# resize the image so that it doesn't look so portrait when printed
org_width, org_height = img.size    #x,y

img_resize = img.resize((org_width, int(org_height/2)))
width, height = img_resize.size
pixels = img_resize.load()


# make a list of ascii characters from the pixel data
charsList = []


# print it out so it looks like an image
for y in range(height):
    for x in range(width):
        brightness = max(pixels[x,y]) / 255 * 100
        print(x,y)
        if brightness < threshold:
            charsList.append('.')
        else:
            charsList.append(' ')
    charsList.append('\n')

with open('ascii.txt', 'w') as f:
    for c in charsList:
        f.write(c)
