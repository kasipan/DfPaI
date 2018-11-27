import peasy.*;

PeasyCam cam;
Table table;
ArrayList<Crater> craters = new ArrayList<Crater>();
final float r = 1737.1; // in km

void setup() {
  size(700, 700, P3D);
  translate(width/2, height/2, 0);
  noFill();
  stroke(255);
  cam = new PeasyCam(this, 0,0,0,0);

  table = loadTable("moon_crater_coords.csv", "header");
  for (TableRow row : table.rows()) {
    float lat = row.getFloat("lat");
    float lon = row.getFloat("lon");
    float dia = row.getFloat("dia");

    craters.add(new Crater(lat, lon,dia));
  }
}


void draw() {
  background(0);
  scale(0.5);  // too large scale makes rendering loss?
  
  for (Crater c : craters) {
    c.draw();
  }
}


class Crater {

  float lat, lon, dia;  // angles and diameter
  
  Crater(float lat, float lon, float dia) {
    this.lat = lat;  //north-south
    this.lon = lon;  //west-east
    this.dia = dia;  //diameter
  }

  void draw() {
    pushMatrix();
      rotateX(lat);
      rotateY(lon);
      translate(0,0,r);
      
      //rotateX(HALF_PI);
      //rotateY(HALF_PI);
      //rotateZ(HALF_PI);
      
      ellipse(0,0,dia,dia);
      //box(10);
    popMatrix();
  }
}
