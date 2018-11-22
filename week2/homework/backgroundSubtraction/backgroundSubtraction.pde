/*
  because of camera's adjust function, it's not working well.
 */
import processing.video.*;

PImage background;
Capture capture;

int pixelsNum;
color[] backgroundPixels, currentPixels;
int threshold = 100;
Boolean showEffect = false;
PImage bg;


void setup() {
  size(640, 480);
  colorMode(HSB, 360, 100, 100);  // how to use hsb parameter in each pixel????

  capture = new Capture(this, width, height);
  capture.start();
  pixelsNum = capture.width * capture.height;

  bg = loadImage("bg.jpg");  // alternative baclground   
  bg.loadPixels();
}


void draw() {
  if (capture.available()) {
    capture.read();

    if (background != null) {
      image(bg, 0, 0);
      loadPixels();

      currentPixels = capture.pixels;  // update pixels array

      for (int i=0; i<backgroundPixels.length; i++) {
        //int currentColor = currentPixels[i];    // maybe it should use HSV 
        int R = (currentPixels[i] >> 16) & 0xFF;
        int G = (currentPixels[i] >> 8) & 0xFF;
        int B = currentPixels[i] & 0xFF;

        //println(R,G,B);

        //color bgColor = backgroundPixels[i];
        int bR = (backgroundPixels[i] >> 16) & 0xFF;
        int bG = (backgroundPixels[i] >> 8) & 0xFF;
        int bB = backgroundPixels[i] & 0xFF;

        int diffR = abs(R - bR);
        int diffG = abs(R - bG);
        int diffB = abs(R - bB);

        // if there is large gap, show captured pixel
        if (diffR+diffG+diffB > threshold) {
          pixels[i] = currentPixels[i];
        }
      }
      updatePixels();
    } else {

      image(capture, 0, 0);  // show just captured image.
    }
  }
}

void keyPressed() {
  showEffect = !showEffect;

  if (showEffect) {
    background = capture.copy();
    backgroundPixels = background.pixels;
    //println(backgroundPixels);
  } else {
    background = null;
  }
}
