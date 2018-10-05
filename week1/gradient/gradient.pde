
size(256, 256);
int totalPixels = width*height;

loadPixels();

// do something here!
for (int i=0; i<totalPixels; i++) {
  pixels[i] = color(i%width, i/height, 100);
}
updatePixels();
