// color HUES

void setup() {
  size(500, 500);
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  int a = (int) map(mouseX, 0, width, 0, 360);
  int b = (int) map(mouseY, 0, width, 0, 100);
  background(a, b, 100);
}
