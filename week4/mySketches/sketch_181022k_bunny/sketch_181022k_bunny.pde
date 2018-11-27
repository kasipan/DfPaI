PShape bunny;

void setup() {
  size(500, 500, P3D);
  bunny = loadShape("bunny.obj");
  noFill();
}

void draw(){
  background(0);
  lights();
  scale(mouseX);
  translate(width/2,height/2,0);
  shape(bunny, 0, 0);
  
}
