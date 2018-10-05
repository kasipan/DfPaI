
size(768, 768);
int totalPixels = width*height;

loadPixels();

for (int i=0; i<totalPixels; i++) {
  pixels[i] = color(map(i%width, 0, width, 0, 256), map(i/height, 0, height, 0, 256), 100);
}

updatePixels();
