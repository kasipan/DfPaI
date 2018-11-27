// rotate
void setup(){
  size(500,500);
}

void draw(){
  background(0);
  //translate(0,0);
  rotate(map(mouseX, 0, width,0,TWO_PI));
  rect(250,250,50,50);
}
