class Ball {
  PVector pos;

  Ball(float x, float y ) {
    pos = new PVector(x, y);
  }
  
  void draw(){
    fill(255);
    ellipse(pos.x, pos.y, 4, 4);
  }
}

ArrayList<Ball> balls = new ArrayList<Ball>(); 

void setup() {
  background(0);
  size(500, 500);
}

void draw(){
  for(Ball b : balls){
    b.draw();
  }
  balls.add(new Ball(mouseX, mouseY));
}
