ArrayList<Box> boxes = new ArrayList<Box>();
int boxesPerLine = 30;

ArrayList<Line> linesInIcosahedron = new ArrayList<Line>();
final float gr = (1.0 + sqrt(5))/2;  // golden ratio
float tl = 200;  //triagle line's length in icosahedron's surface 

ArrayList<Line> linesInCube = new ArrayList<Line>();
float cl = 500;  // Cube's side length. 
float cl_h = cl/2;


void setup() {
  size(500, 500, P3D);
  noStroke();
  fill(250, 50);
  blendMode(ADD);

  // Create a Cube with Lines
  PVector[] cubeVertexIndices = {
    new PVector(-cl_h, -cl_h, cl_h), new PVector(cl_h, -cl_h, cl_h), new PVector(cl_h, -cl_h, -cl_h), new PVector(-cl_h, -cl_h, -cl_h), // Top
    new PVector(-cl_h, cl_h, cl_h), new PVector(cl_h, cl_h, cl_h), new PVector(cl_h, cl_h, -cl_h), new PVector(-cl_h, cl_h, -cl_h)  // Bottom
  };
  for (int i=0; i<cubeVertexIndices.length; i++) {
    PVector tgt = cubeVertexIndices[i];

    for (int j=i+1; j<cubeVertexIndices.length; j++) {
      PVector cmp = cubeVertexIndices[j];
      // Check distance betweeb each vertex and set line
      float dist = PVector.dist(tgt, cmp);
      if (int(dist) == cl) {
        linesInCube.add(new Line(tgt, cmp));
      }
    }
  }


  // Create a Icosahedron with Lines
  PVector[] icosaVertexIndices = {
    new PVector(tl*gr, 0, tl), new PVector(tl*gr, 0, -tl), new PVector(-tl*gr, 0, -tl), new PVector(-tl*gr, 0, tl), // X dimention
    new PVector(tl, tl*gr, 0), new PVector(-tl, tl*gr, 0), new PVector(-tl, -tl*gr, 0), new PVector(tl, -tl*gr, 0), // Y dimention
    new PVector(0, tl, tl*gr), new PVector(0, -tl, tl*gr), new PVector(0, -tl, -tl*gr), new PVector(0, tl, -tl*gr)  // Z dimention
  };
  for (int i=0; i<icosaVertexIndices.length; i++) {
    PVector tgt = icosaVertexIndices[i];

    for (int j=i+1; j<icosaVertexIndices.length; j++) {
      PVector cmp = icosaVertexIndices[j];
      // Check distance and set line
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
  scale(sin(frameCount*0.02));  // scale whole

  if (sin(frameCount*0.02) > sin(PI)) {
    //1st cycle is for drawing a icosahedron 
    for (Line l : linesInIcosahedron) {
      l.draw();
    }
  } else {
    //2nd cycle is drawing a cube
    for (Line l : linesInCube) {
      l.draw();
    }
  }
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
    scale(1/sin(frameCount*0.02));  // fix box's size
    box(boxSize);
    popMatrix();
  }
}


class Line {
  PVector start, end;
  Box[] boxes= new Box[boxesPerLine];

  Line(PVector start, PVector end) {
    this.start = new PVector(start.x, start.y, start.z);
    this.end = new PVector(end.x, end.y, end.z);

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
