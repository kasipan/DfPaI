from wand.image import Image
img = Image(filename="hand.jpg")
# pixels = []

# pixelateRange = [10, 10]
#
height = img.height
width = img.width
#
# for y in range(height):
#     for x in range(width):
#
#         x +=1
#     y += 1
#
#
# for x in range(img.width):
#     for y in range(img.height):
#         print(x,y, img[x, y])
#         pixels.append(img[x, y])
#
# print(pixels)



with img.clone() as resize:
    resize.resize(int(width*0.05), int(height*0.05), 'undefined', 0.1)
    resize.resize(width, height, 'undefined', 0.1)
    resize.save(filename='resize.jpg')
