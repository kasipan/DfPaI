import processing.video.*;
import gab.opencv.*;

Capture capture;
OpenCV opencv;
PImage output;

void setup() {
  size(640, 480);
  background(0);

  capture = new Capture(this, width/2, height/2);
  capture.start();

  opencv = new OpenCV(this, capture);
}

void draw() {
  if (capture.available()) {
    capture.read();  // frame is ready?
    println("in");
    
    image(capture, 0, 0);
    
    opencv.loadImage(capture);
    int thresholdAmount = 100;
    opencv.threshold(thresholdAmount);
    
    output = opencv.getOutput();  // PImage
    translate(0, capture.height);
    image(output, 0, 0);
  }
  println("out");
  println("----");
  
}
