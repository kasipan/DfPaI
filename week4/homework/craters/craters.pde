import peasy.*;

Table table;
PeasyCam cam;
float moonRadius = 1737.1; // in km
ArrayList<Crater> craters = new ArrayList<Crater>();

void setup() {
  size(640, 640, P3D);
  stroke(255);
  noFill();
  translate(width/2, height/2, 0);


  cam = new PeasyCam(this, 2000);

  table = loadTable("moon_crater_coords.csv", "header");
  for (TableRow row : table.rows()) {
    float lat = row.getFloat("lat");
    float lon = row.getFloat("lon");
    float dia = row.getFloat("dia");

    craters.add(new Crater(lat, lon, dia));
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
    this.lat = lat;  //west-east
    this.lon = lon;  //north-south
    this.dia = dia;  //diameter
  }

  void draw() {
    pushMatrix();
    rotateY(lat);
    rotateX(lon);
    translate(0, 0, moonRadius);
    
    //rotateX(HALF_PI);
    //rotateY(HALF_PI);
    //rotateZ(HALF_PI);

    ellipse(0, 0, dia, dia);
    //box(10);
    popMatrix();
  }
}
