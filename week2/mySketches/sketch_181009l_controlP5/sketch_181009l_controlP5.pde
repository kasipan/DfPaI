
import controlP5.*;

ControlP5 cp5;

int backgroundColor = 0;

void setup() {
  size(500, 500);
  cp5 = new ControlP5(this);
  cp5.addSlider("backgroundColor").setRange(0,255).setPosition(30,30);
}


void draw() {
  background(backgroundColor);

  
}

void keyPressed() {
  if (cp5.isVisible()) {
    cp5.hide();
  } else {
    cp5.show();
  }
}
