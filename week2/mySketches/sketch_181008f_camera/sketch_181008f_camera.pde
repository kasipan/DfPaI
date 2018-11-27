import processing.video.*;

Capture capture;
int counter = 0;

void setup() {
  size(640, 480);
  capture = new Capture(this, width, height);
  capture.start();
}

void draw() {
  if (capture.available()) {
    capture.read();
  }
  
  loadPixels();
  
  for(int x=0; x<width; x++){
    pixels[(x+width)*counter] = capture.pixels[x];
  }
  //image(capture, 0, 0);
  updatePixels();
  counter++;
}
