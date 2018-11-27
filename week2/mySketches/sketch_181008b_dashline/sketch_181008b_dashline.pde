// atempt to draw dash line

ArrayList<PVector> positions = new ArrayList<PVector>(); 

void setup() {
  background(0);
  size(500, 500);
  noFill();
}

void draw() {
  if (positions.size()>=3) {
    for (int i = 1; i < positions.size(); i+=2) {
      PVector start = positions.get(i-1);
      PVector end = positions.get(i);
      line(start.x, start.y, end.x, end.y);
    }
  }
}


void mouseMoved() {
  positions.add(new PVector(mouseX, mouseY));
}
