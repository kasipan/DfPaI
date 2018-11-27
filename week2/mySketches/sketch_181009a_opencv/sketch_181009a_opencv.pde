import gab.opencv.*;

PImage img, output;
OpenCV opencv;

void settings() {
  img = loadImage("test.jpg");
  size(img.width, img.height * 2);
}

void setup() {

  opencv = new OpenCV(this, img);
}

void draw() {
  background(220,100,0);

  //1st
  opencv.loadImage(img);
  //int blurAmount = (int)map(mouseY, 0, height, 0, 255);
  int blurAmount = 10;
  //opencv.blur(blurAmount);
  //opencv.contrast(2);
  //opencv.invert();
  
  int thresholdAmount = (int)map(mouseX, 0, width, 0, 255);
  opencv.threshold(thresholdAmount);

  opencv.invert();
  output = opencv.getOutput();

  image(output, 0, 0);


  // 2nd
  ArrayList<Contour> contours;
  contours = opencv.findContours();


  //image(output, 0, img.height);
  stroke(255);
  noFill();
  println(contours.size());

  translate(0, img.height);
  image(img, 0, 0);

  for (Contour contour : contours) {
    contour.draw();
  }
}
