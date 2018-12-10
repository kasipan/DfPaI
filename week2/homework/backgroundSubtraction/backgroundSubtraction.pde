import controlP5.*;
import processing.video.*;

/*
  because of camera's adjust function, it's not working well.
 */
PImage background;
Capture capture;

int pixelsNum;
color[] backgroundPixels, currentPixels;
float THRESHOLD_HUE = 0.5;
float THRESHOLD_SAT = 8.5;
float THRESHOLD_BRT = 0;
float THRESHOLD_RGB = 200; 
Boolean showEffect = false;
PImage bg;

ControlP5 cp5;


void setup() {
  size(640, 480);
  colorMode(HSB, 360, 100, 100);  // how to use hsb parameter in each pixel????

  capture = new Capture(this, width, height);
  capture.start();
  pixelsNum = capture.width * capture.height;

  bg = loadImage("bg.jpg");  // alternative background   
  bg.loadPixels();


  cp5 = new ControlP5(this);
  cp5.addSlider("THRESHOLD_HUE")
    .setPosition(20, 20)
    .setWidth(200)
    .setRange(0, 360)
    ;
  cp5.addSlider("THRESHOLD_SAT")
    .setPosition(20, 40)
    .setWidth(200)
    .setRange(0, 100)
    ;
  cp5.addSlider("THRESHOLD_BRT")
    .setPosition(20, 60)
    .setWidth(200)
    .setRange(0, 100)
    ;
  cp5.addSlider("THRESHOLD_RGB")
    .setPosition(20, 80)
    .setWidth(200)
    .setRange(0, 300)
    ;
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
        float currentBrt = brightness(currentPixels[i]);
        int R = (currentPixels[i] >> 16) & 0xFF;
        int G = (currentPixels[i] >> 8) & 0xFF;
        int B = currentPixels[i] & 0xFF;

        float beforeHue = hue(backgroundPixels[i]); 
        float beforeSat = saturation(backgroundPixels[i]);
        float beforeBrt = brightness(backgroundPixels[i]);
        int bR = (backgroundPixels[i] >> 16) & 0xFF;
        int bG = (backgroundPixels[i] >> 8) & 0xFF;
        int bB = backgroundPixels[i] & 0xFF;

        float diffHue = calcurateDiffInCycle(currentHue, beforeHue, 360);
        float diffSat = calcurateDiffInCycle(currentSat, beforeSat, 100);
        float diffBrt = calcurateDiffInCycle(currentBrt, beforeBrt, 100);
        //println(diffHue, diffSat);
        int diffR = abs(R - bR);
        int diffG = abs(G - bG);
        int diffB = abs(B - bB);
        
        
        // if there is a large gap, show current caputured pixel
        if (diffHue > THRESHOLD_HUE && diffSat > THRESHOLD_SAT && diffBrt > THRESHOLD_BRT ||  diffR+diffG+diffB > THRESHOLD_RGB) {
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


// I ' m    s o    s t u p i d . . .
float calcurateDiffInCycle(float a, float b, float max) {
  float r = abs(a - b);

  // like 355 - 5, it should be 355 - 365. There must be other proper methods... 
  if (r > max/2) {
    if (a < b) {
      r = a+max - b;
    }
    if (b < a) {
      r = b+max - a;
    }
  }
  return r;
}
