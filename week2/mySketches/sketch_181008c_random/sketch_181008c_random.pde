// beautiful failure 

void setup() {
  size(500, 500);
  background(0);
  //noStroke();
  stroke(255);

  for (int i = 0; i < width; i++) {
    line(i, height/2, height/2, random(height/2));
  }
}
