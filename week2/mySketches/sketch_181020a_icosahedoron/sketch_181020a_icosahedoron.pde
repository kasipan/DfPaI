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
  
  float[][][] vertexesMatrix = {
    {{l*gr, 0, l},{l*gr, 0, -l},{-l*gr, 0, -l},{-l*gr, 0, l}},  // X dimention
    {{l, l*gr, 0},{-l, l*gr, 0},{-l, -l*gr, 0},{l, -l*gr, 0}},  // Y dimention
    {{0, l, l*gr},{0, -l, l*gr},{0, -l, -l*gr},{0, l, -l*gr}}  // Z dimention
  };
  
  
  for(int i=0; i<vertexesMatrix.length; i++){
    beginShape();
    for(int j=0; j<vertexesMatrix[i].length; j++){
      vertex(vertexesMatrix[i][j][0],vertexesMatrix[i][j][1],vertexesMatrix[i][j][2]);  // testing
      
      // check every distance
      // drawline
    }
    endShape(CLOSE);
  }
  
  
  // testing
  //beginShape();
  //vertex(l*gr, 0, l);  // surfaceX
  //vertex(l*gr, 0, -l);
  //vertex(-l*gr, 0, -l);
  //vertex(-l*gr, 0, l);
  //endShape(CLOSE);

  //beginShape();
  //vertex(l, l*gr, 0);  // surfaceY
  //vertex(-l, l*gr, 0);
  //vertex(-l, -l*gr, 0);
  //vertex(l, -l*gr, 0);
  //endShape(CLOSE);

  //beginShape();
  //vertex(0, l, l*gr);  // surfaceZ
  //vertex(0, -l, l*gr);
  //vertex(0, -l, -l*gr);
  //vertex(0, l, -l*gr);
  //endShape(CLOSE);
}
