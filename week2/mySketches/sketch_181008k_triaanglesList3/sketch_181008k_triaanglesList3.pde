//make triangles following mouse
class Triangle {  
  float rotation;
  PVector pos;


  Triangle(float x, float y, float rotation) {
    this.pos = new PVector(x, y);
    this.rotation = rotation;  // rotation
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    triangle(-w/2, h/2, 0, -h/2, w/2, h/2);
    popMatrix();
  }

  void update() {
    if (followTrigger) {
      // mouse observation
      PVector mPos = new PVector(mouseX, mouseY);
      PVector dir = PVector.sub(mPos, pos);
      rotation = HALF_PI+dir.heading();
    } else {
      rotation = 0;
    }
  }

  void changeDirection(float rotation) {
    this.rotation = rotation;
  }
}


//int totalNum = 100;
ArrayList<Triangle> triangles = new ArrayList<Triangle>();
int lastFrameCountSeconds = 0;
int w = 20;
int h = 25;
int margin = 50;
boolean followTrigger = true;

void setup() {
  size(500, 500);
  for (int i=margin; i<width; i+=margin) {
    for (int j=margin; j<height; j+=margin) {
      triangles.add( new Triangle(i, j, random(360)) );
    }
  }
}

void draw() {
  background(0);
  for (Triangle tri : triangles) {
    tri.update();  //followMouse
    tri.draw();
  }
}


//void mouseMoved() {
//  for (Triangle tri : triangles) {
//    tri.update();  //followMouse
//  }
//}

void keyPressed() {
  followTrigger = !followTrigger;  // switch fix to rotate
}
