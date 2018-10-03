int faceSize = 50;
int eyeSize = 5;

void setup() {
  size(500, 500);
  ellipseMode(CENTER);
}

void draw() {
  background(0);

  for (int x=0; x<10; x++) {
    for (int y=0; y<10; y++) {
      smile((x+0.5)*faceSize, (y+0.5)*faceSize);
    }
  }
}

void smile(float x, float y) {
  pushMatrix();
  translate(x, y);

  //face
  fill(255);
  ellipse(0, 0, faceSize, faceSize);

  //facialMove
  float dist_x = mouseX-x;
  float dist_y = mouseY-y;
  float moving_x = (abs(dist_x) <= 1) ? 0 : dist_x/80+1/dist_x;
  float moving_y = (abs(dist_y) <= 1) ? 0 : dist_y/80+1/dist_y;

  //blink
  boolean blinkFlg = (0.9999<random(0,1)) ? true : false;

  //eyes
  if(!blinkFlg){
    fill(0);
    ellipse(-0.2*faceSize+moving_x, -0.1*faceSize+moving_y, eyeSize, eyeSize);
    ellipse(0.2*faceSize+moving_x, -0.1*faceSize+moving_y, eyeSize, eyeSize);
  }

  //mouth
  noFill();
  arc(0+moving_x, 10+moving_y, 10, 7.5, 0, PI);

  popMatrix();
}
