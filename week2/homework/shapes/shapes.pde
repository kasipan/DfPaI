ArrayList<Box> boxes = new ArrayList<Box>();
int boxesPerLine = 30;
Line line;

void setup() {
  size(500, 500, P3D);
  noStroke();
  fill(250, 50);
  blendMode(ADD);

  //for (int i=0; i<boxesPerLine; i++) {
  //  float x = i*10;
  //  boxes.add(new Box(x, 0, 0));
  //}


  PVector start = new PVector(-width/2, -100, 0);
  PVector end = new PVector(width/2, -100, 0);
  line = new Line(start, end);
}


void draw() {
  background(30);

  translate(width / 2, height / 2, -600);
  line.draw();
}



class Box {
  float boxSize = 10.0;
  float amt, vel;
  PVector pos;

  Box() {
    vel = random(0.001);
    amt = random(1);  // box's position should be between start and end point
  }


  void update(PVector start, PVector end) {
    float x = lerp(start.x, end.x, amt);
    float y = lerp(start.y, end.y, amt);
    float z = lerp(start.z, end.z, amt);

    pos = new PVector(x, y, z);
    amt += vel;
    if (amt > 1){
      amt = 0;
    }
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(boxSize);
    popMatrix();
  }
}


class Line {
  PVector start, end;
  Box[] boxes= new Box[boxesPerLine];

  Line(PVector a, PVector b) {
    start = new PVector(a.x, a.y, a.z);
    end = new PVector(b.x, b.y, b.z);
    
    // setup boxes
    for (int i=0; i<boxes.length; i++) {
      boxes[i] = new Box();
    }
  }

  void updateBoxes() {
    for (Box b : boxes) {
      b.update(start, end);
    }
  }

  void draw() {
    stroke(255);
    //line(start.x, start.y, start.z, end.x, end.y, end.z);
    noStroke();
    for (Box b : boxes) {
      b.update(start, end);
      b.draw();
    }
  }
}
