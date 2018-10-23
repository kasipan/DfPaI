ArrayList<Box> boxes = new ArrayList<Box>();
int boxesPerLine = 30;

ArrayList<Line> linesInIcosahedron = new ArrayList<Line>();
final float gr = (1.0 + sqrt(5))/2;  // golden ratio
float tl = 200;  //icosahedron's triagle line's length

ArrayList<Line> linesInCube = new ArrayList<Line>();
float cubeSideLength = 500;


void setup() {
  size(500, 500, P3D);
  noStroke();
  fill(250, 50);
  blendMode(ADD);

  // Create a Cube with Lines
  PVector p1 = new PVector(-cubeSideLength/2, -cubeSideLength/2, cubeSideLength/2);
  PVector p2 = new PVector(cubeSideLength/2, -cubeSideLength/2, cubeSideLength/2);
  PVector p3 = new PVector(cubeSideLength/2, -cubeSideLength/2, -cubeSideLength/2);
  PVector p4 = new PVector(-cubeSideLength/2, -cubeSideLength/2, -cubeSideLength/2);
  PVector p5 = new PVector(-cubeSideLength/2, cubeSideLength/2, cubeSideLength/2);
  PVector p6 = new PVector(cubeSideLength/2, cubeSideLength/2, cubeSideLength/2);
  PVector p7 = new PVector(cubeSideLength/2, cubeSideLength/2, -cubeSideLength/2);
  PVector p8 = new PVector(-cubeSideLength/2, cubeSideLength/2, -cubeSideLength/2);
  linesInCube.add(new Line(p1, p2));
  linesInCube.add(new Line(p2, p3));
  linesInCube.add(new Line(p3, p4));
  linesInCube.add(new Line(p4, p1));
  linesInCube.add(new Line(p1, p5));
  linesInCube.add(new Line(p2, p6));
  linesInCube.add(new Line(p3, p7));
  linesInCube.add(new Line(p4, p8));
  linesInCube.add(new Line(p5, p6));
  linesInCube.add(new Line(p6, p7));
  linesInCube.add(new Line(p7, p8));
  linesInCube.add(new Line(p8, p5));

  // Create a icosa with Lines
  //float[][][] vertexIndices_old = {
  //  {{tl*gr, 0, tl}, {tl*gr, 0, -tl}, {-tl*gr, 0, -tl}, {-tl*gr, 0, tl}}, // X dimention
  //  {{tl, tl*gr, 0}, {-tl, tl*gr, 0}, {-tl, -tl*gr, 0}, {tl, -tl*gr, 0}}, // Y dimention
  //  {{0, tl, tl*gr}, {0, -tl, tl*gr}, {0, -tl, -tl*gr}, {0, tl, -tl*gr}}  // Z dimention
  //};

  PVector[] vertexIndices = {
    new PVector(tl*gr, 0, tl), new PVector(tl*gr, 0, -tl), new PVector(-tl*gr, 0, -tl), new PVector(-tl*gr, 0, tl), // X dimention
    new PVector(tl, tl*gr, 0), new PVector(-tl, tl*gr, 0), new PVector(-tl, -tl*gr, 0), new PVector(tl, -tl*gr, 0), // Y dimention
    new PVector(0, tl, tl*gr), new PVector(0, -tl, tl*gr), new PVector(0, -tl, -tl*gr), new PVector(0, tl, -tl*gr)  // Z dimention
  };

  for (int i=0; i<vertexIndices.length; i++) {
    PVector tgt = vertexIndices[i];

    // Check distance and draw line
    for (int j=i+1; j<vertexIndices.length; j++) {
      PVector cmp = vertexIndices[j];
      float dist = PVector.dist(tgt, cmp);
      if (int(dist) == int(tl*2)) {
        linesInIcosahedron.add(new Line(tgt, cmp));
      }
    }
  }
}




void draw() {
  background(30);

  translate(width / 2, height / 2, -500);
  rotateX(frameCount*0.003);
  rotateY(frameCount*0.003);
  scale(sin(frameCount*0.01));  // scale whole

  //if (sin(frameCount*0.01) > sin(PI)) {
    // 1st cycle is for drawing a icosahedron 
    for (Line l : linesInIcosahedron) {
      l.draw();
    }
 // } else {
    // 2nd cycle is drawing a cube
   // for (Line l : linesInCube) {
     // l.draw();
   // }
  //}
}



class Box {
  float boxSize = 8.0;
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
    if (amt > 1) {
      amt = 0;
    }
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    scale(1/sin(frameCount*0.01));  // fix box's size
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

  void draw() {
    for (Box b : boxes) {
      b.update(start, end);
      b.draw();
    }
  }
}
