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
  colorMode(HSB, 360, 100, 100);
  
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
        int cR = (currentPixels[i] >> 16) & 0xFF;
        int cG = (currentPixels[i] >> 8) & 0xFF;
        int cB = currentPixels[i] & 0xFF;

        float beforeHue = hue(backgroundPixels[i]); 
        float beforeSat = saturation(backgroundPixels[i]);
        float beforeBrt = brightness(backgroundPixels[i]);
        int bR = (backgroundPixels[i] >> 16) & 0xFF;
        int bG = (backgroundPixels[i] >> 8) & 0xFF;
        int bB = backgroundPixels[i] & 0xFF;

        float diffHue = calcurateDiffInCycle(currentHue, beforeHue, 360);
        float diffSat = abs(currentSat - beforeSat);
        float diffBrt = abs(currentBrt - beforeBrt);
        int diffR = abs(cR - bR);
        int diffG = abs(cG - bG);
        int diffB = abs(cB - bB);
        
        
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


// just a function to calcurate gap between two angles... Maybe, there is a better way.
float calcurateDiffInCycle(float a, float b, float max) {
  float s = abs(a - b);

  // like 355 - 5, it should be 355 - 365. There must be other proper methods... 
  if (s > max/2) {
    if (a < b) {
      s = a+max - b;
    }
    if (b < a) {
      s = b+max - a;
    }
  }
  return s;
}
