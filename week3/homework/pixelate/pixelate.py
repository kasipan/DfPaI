from wand.image import Image

fileName = input("Input filename with its extension: ")
img = Image(filename=fileName)

height = img.height
width = img.width

with img.clone() as resize:
    resize.resize(int(width*0.05), int(height*0.05), 'box', 1)
    resize.resize(width, height, 'box', 1)
    resize.save(filename='resize.jpg')
    print("Completed.")
