
class Triangle {
  PVector pos;
  float rotation;
 
  Triangle(float x, float y) {
    pos = new PVector(x, y);
    rotation = 0;
  }
  
  void faceTowards(float x, float y) {
    PVector mPos = new PVector(x, y);  // mouseX,Y
    PVector dir = PVector.sub(mPos, pos);  // caclurate distance from mouse to each triangles 
    //rotation = HALF_PI+dir.heading();  // initial rotation(90degree) + adjustment
    rotation = HALF_PI+atan2(dir.y, dir.x);    // same above ;p
  }


  void draw() {
    stroke(255, 0, 120);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    scale(2, 2);
    triangle(-5, 2, 5, 2, 0, -10);
    popMatrix();
  }

}

ArrayList<Triangle> friends = new ArrayList<Triangle>();

void setup() {
  size(500, 500);
  
  int N = 10;
  int spacing = width / (N + 1);
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      friends.add(new Triangle( i * spacing + spacing, j * spacing + spacing ));
    }
  }
}

void draw() {
  background(0);

  for (Triangle t : friends) {
    t.faceTowards(mouseX, mouseY);
    t.draw();
  }
}
