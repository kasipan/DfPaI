//make a icosahedron with golden ratio rectangles

float gr = (1.0 + sqrt(5))/2;  // golden ratio
float l = 100;

void setup() {
  size(500, 500, P3D);
  stroke(250);
  noFill();
  blendMode(ADD);
}

void draw() {
  background(30);

  translate(width / 2, height / 2, -100);

  rotateY(mouseX*-0.01);
  rotateX(mouseY*-0.01);

  //PVector[] vectors = new PVector[12];


  float[][][] vertexesMatrix = {
    {{l*gr, 0, l}, {l*gr, 0, -l}, {-l*gr, 0, -l}, {-l*gr, 0, l}}, // X dimention
    {{l, l*gr, 0}, {-l, l*gr, 0}, {-l, -l*gr, 0}, {l, -l*gr, 0}}, // Y dimention
    {{0, l, l*gr}, {0, -l, l*gr}, {0, -l, -l*gr}, {0, l, -l*gr}}  // Z dimention
  };



  for (int i=0; i<vertexesMatrix.length; i++) {
    //beginShape();
    for (int j=0; j<vertexesMatrix[i].length; j++) {
      int z = j+1;
      //vertex(vertexesMatrix[i][j][0],vertexesMatrix[i][j][1],vertexesMatrix[i][j][2]);  // testing
      if (z > 3) {
        z = 0;
      }

      PVector start  = new PVector(vertexesMatrix[i][j][0], vertexesMatrix[i][j][1], vertexesMatrix[i][j][2]);
      PVector end  = new PVector(vertexesMatrix[i][z][0], vertexesMatrix[i][z][1], vertexesMatrix[i][z][2]);
      // check every distance
      line(start.x, start.y, start.z, end.x, end.y, end.z);
      // drawline
    }
    //endShape(CLOSE);
  }
}
