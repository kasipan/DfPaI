float angle;
int numRows = 100;
int dotsPerRow = 20;
PVector[] positions;

float rowSpacing = 5;
float sideLength = rowSpacing * (numRows-1);

float circleRadius = 200;

float sphereYOffset = 200;
float fraction;


void setup() {
  size(512, 512, P3D);
  noStroke();
  fill(50);
  positions = new PVector[numRows*dotsPerRow];

  for (int rowNumber = 0; rowNumber<numRows; rowNumber++) {
    for (int j = 0; j<dotsPerRow; j++) {
      float x = rowNumber * rowSpacing;
      float y = 0;
      float z = random(sideLength);

      float d = dist(x, z, sideLength/2, sideLength/2);  // why not - bc -> before moving?
      if (d < circleRadius) {
        float h = sqrt(sq(circleRadius)-sq(d));
        if (d > circleRadius*9.5/10 && random(0, 1)<0.3) {
          y = h - sphereYOffset;  // fraction
        } else {
          y = -h - sphereYOffset;
        }
      }


      int index = rowNumber*dotsPerRow + j;
      positions[index] = new PVector(x, y, z);
    }
  }
}


void draw() {
  background(210);  // TODO add gradient by myself!

  translate(width/2, height/2+280, -300);
  rotateY(radians(angle));  // rotatetion's axis is Y

  translate(-sideLength/2, 0, -sideLength/2);  // custom origin

  for (PVector pos : positions) {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(2);
    popMatrix();
  }

  //translate(0, height/3, 0);  // from second origin
  //rotateY(radians(angle));
  //sphere(60);

  angle+=0.2;
}
