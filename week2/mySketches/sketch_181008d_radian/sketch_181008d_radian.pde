void setup() {
  size(500, 500);
  background(0);
  stroke(255);
  noFill();
}
void draw(){
  background(0);
  translate(0, height/2);
  beginShape();
  for (float i=0; i<width; i++) {
    //vertex(i, -sin(i/width*TWO_PI*mouseX)*height/4);
    vertex(i, -sin(map(i, 0, width, 0, TWO_PI*mouseX)) * height/4);
  }
  endShape();
}
