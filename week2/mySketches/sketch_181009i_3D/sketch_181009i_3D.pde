float angle;

void setup() {
  size(512, 512, P3D);
  noFill();
}


void draw(){
  background(210);
  translate(width/2,mouseY,0);
  rotateY(radians(angle));  // axis is Y
  box(60);
  
  translate(0,height/3,0);  // from second origin
  rotateY(radians(angle));
  sphere(40);
  
  angle++;
  
  
}
