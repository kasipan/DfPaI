int totalPixels;
int counter = 0;
void setup() {
  size(768, 768);
  totalPixels = width*height;
}
void draw() {
  loadPixels();


  for (int i=0; i<totalPixels; i++) {
    float rad = radians(i+counter);
    float r = map(i%width+(cos(rad))+mouseX, 0, width, 0, 256);
    float g = map(i/height+(i%300)+mouseY, 0, height, 0, 256);
    float b = 256;
    pixels[i] = color(r, g, b);
  }

  updatePixels();
  counter += 0.1;
}
