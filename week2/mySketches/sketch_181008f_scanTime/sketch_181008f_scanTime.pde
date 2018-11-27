import processing.video.*;

Capture capture;
int y, y2;

void setup() {
  size(640, 480);
  capture = new Capture(this, width, height);
  capture.start();
  y = height-1;
  y2 = 0;
}

void draw() {
  if (capture.available()) {
    capture.read();
  }

  loadPixels();
  for (int x=0; x<width; x++) {
    color col = capture.pixels[x+y2*width];
    pixels[x+y*width] = col; 
  }
  updatePixels();
  y--;
  y2++; // make opposed
}


void mousePressed(){
  loop();
}
