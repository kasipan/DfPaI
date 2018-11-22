/*
  because of camera's adjust function, it's not working well.
 */
import processing.video.*;

PImage background;
Capture capture;

int pixelsNum;
color[] backgroundPixels, currentPixels;
int threshold = 30;
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
        float currentHue = hue(currentPixels[i]);    // maybe it should use HSV 
        float currentSat = saturation(currentPixels[i]);

        float bgHue = hue(backgroundPixels[i]); 
        float bgSat = saturation(backgroundPixels[i]);
        
        float diff = abs(currentHue-bgHue) + abs(currentSat-bgSat);

        // if there is a large gap, show captured pixel
        if (diff > threshold) {
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
