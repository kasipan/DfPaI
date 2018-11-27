void setup() {
  size(500, 500);
  background(0);
  stroke(255);
  noFill();

  beginShape();
  for (int i = 0; i < width; i+=5) {
    vertex (i, random(height/4));
  }
  endShape();

  translate(0, height/4);
  beginShape();
  for (float i = 0; i< width; i+=5) {
    vertex(i, noise(i/100) * height/4 + offset);
  }
  endShape();
}
