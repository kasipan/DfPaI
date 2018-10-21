int count = 0;
ArrayList<Box> boxes = new ArrayList<Box>();
int boxesPerLine = 24;

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
  float[][][] vertexesMatrix = {
    {{tl*gr, 0, tl}, {tl*gr, 0, -tl}, {-tl*gr, 0, -tl}, {-tl*gr, 0, tl}}, // X dimention
    {{tl, tl*gr, 0}, {-tl, tl*gr, 0}, {-tl, -tl*gr, 0}, {tl, -tl*gr, 0}}, // Y dimention
    {{0, tl, tl*gr}, {0, -tl, tl*gr}, {0, -tl, -tl*gr}, {0, tl, -tl*gr}}  // Z dimention
  };
  for (int i=0; i<vertexesMatrix.length; i++) {
    for (int j=0; j<vertexesMatrix[i].length; j++) {
      PVector tgt = new PVector(vertexesMatrix[i][j][0], vertexesMatrix[i][j][1], vertexesMatrix[i][j][2]);
      
      // Check distance and draw line
      for (int ii=0; ii<vertexesMatrix.length; ii++) {
        for (int jj=0; jj<vertexesMatrix[ii].length; jj++) {
          PVector cmp = new PVector(vertexesMatrix[ii][jj][0], vertexesMatrix[ii][jj][1], vertexesMatrix[ii][jj][2]);
          float dist = PVector.dist(tgt, cmp);
          //println(int(dist));
          if (int(dist) == int(tl*2)) {
            linesInIcosahedron.add(new Line(tgt, cmp));
          }
        }
      }
    }
  }
  
}



void draw() {
  background(30);

  translate(width / 2, height / 2, -600);
  scale(sin(count*0.01));
  rotateY(mouseX*-0.01);
  rotateX(mouseY*-0.01);
  
  if(sin(count*0.01) > sin(PI)){
    // 1st cycle of count is for drawing a icosahedron 
    for (Line l : linesInIcosahedron){
      l.draw();
    }
  } else {
    // 2nd cycle is drawing a cube
    for (Line l : linesInCube) {
      l.draw();
    }
  }
  count++;

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
    // Check
    //stroke(255);
    //line(start.x, start.y, start.z, end.x, end.y, end.z);
    //noStroke();
    for (Box b : boxes) {
      b.update(start, end);
      b.draw();
    }
  }
}
