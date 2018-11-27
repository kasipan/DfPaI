//make triangles
int totalNum = 10;
ArrayList<Triangle> triangles = new ArrayList<Triangle>();
int lastFrameCountSeconds = 0;

class Triangle {  
  float rotation;
  PVector pos;
  boolean alive;

  Triangle(float x, float y, float rotation) {
    this.pos = new PVector(x, y);
    this.rotation = rotation;
    alive = false;
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    triangle(-5, 5, 0, -5, 5, 5);
    popMatrix();
  }

  void update() {
    if (alive) {
      rotation += 0.2;
    }
  }

  void wakeUp() {
    alive = !alive;
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
    tri.update();
    tri.draw();
  }
  
  int frameCountSeconds = frameCount / 60;
  if (lastFrameCountSeconds != frameCountSeconds) {
    int index = frameCountSeconds-1;
    if (index<triangles.size()){
      Triangle tri = triangles.get(index);
      tri.wakeUp();
    }
    lastFrameCountSeconds = frameCountSeconds;
  }
}

void mousePressed() {
  triangles.add( new Triangle(random(width), random(height), random(0, 360)) );
  //triangles.get(0).wakeUp();
}
