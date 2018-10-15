ArrayList<Box> boxes = new ArrayList<Box>();
int boxesPerLine = 20;

void setup() {
  size(500, 500, P3D);
  noStroke();
  fill(250, 50);
  blendMode(ADD);

  for (int i=0; i<boxesPerLine; i++) {
    float x = i*10;
    boxes.add(new Box(x, 0, 0));
  }
}


void draw() {
  background(30);

  translate(width / 2, height / 2, -400);
  for (Box b : boxes) {
    b.update();
    b.draw();
  }
}



class Box {
  float boxSize = 10.0;
  PVector pos, vel;

  Box(float x, float y, float z) {
    pos = new PVector(x, y, z);
    vel = new PVector(random(2), 0, 0);
  }


  void update() {
    pos.add(vel);
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(boxSize);
    popMatrix();
  }
}


//class Line {
//  PVector start, end;
//  PVector dis;
//  Box[] boxes= new Box[boxesPerLine];
  
//  Line(PVector a, PVector b) {
//    a = new PVector(a.x, a.y, a.z);
//    b = new PVector(b.x, b.y, b.z);
//  }

//  void generate(PVector a, PVector b) {
//    PVector c = PVector.sub(a, b);
//    for (int i=0; i<boxesPerLine; i++) {
//      c.mult(random(0.01, 0.99));
//      boxes[i] = new Box(c.x, c.y, c.z);
//      boxes[i].update();
//      boxes[i].display();
//    }
//  }

//  void display() {
//  }

//}
