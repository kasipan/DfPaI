//make triangles
int totalNum = 10;
ArrayList<Triangle> triangles = new ArrayList<Triangle>();
int lastFrameCountSeconds = 0;

class Triangle {  
  float rotation;
  PVector pos;

  Triangle(float x, float y, float rotation) {
    this.pos = new PVector(x, y);
    this.rotation = 0;
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    triangle(-5, 5, 0, -5, 5, 5);
    popMatrix();
  }

  //void update() {
  //  rotation += 0.2;
  //}
  
  void changeDirection(float rotation){
    this.rotation = rotation;
  }

}


void setup() {
  size(500, 500);
  for (int i=0; i<totalNum; i++) {
    triangles.add( new Triangle(random(width), random(height), random(360)) );
  }
}

void draw() {
  background(0);
  for (Triangle tri : triangles) {
    //tri.update();
    tri.draw();
  }
  
}

void mousePressed() {
  float newRotation = random(360);
  for (Triangle tri : triangles) {
    tri.changeDirection(newRotation);
  }
}
