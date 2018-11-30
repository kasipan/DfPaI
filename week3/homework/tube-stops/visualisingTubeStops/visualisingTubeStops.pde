import netP5.*;
import oscP5.*;

OscP5 oscP5;
ArrayList<Line> lines  = new ArrayList<Line>();
float stopRadius = 10;

void setup() {
  size(700, 700);
  //blendMode(ADD);
  noStroke();

  oscP5 = new OscP5(this, 5000);
}

void draw() {
  background(255);
  translate(width/2, height/2);

  try {
    for (Line l : lines) {
      l.draw();
    }
  }
  catch (Exception e) {
  }
}



void oscEvent(OscMessage message) {
  // add a line
  if (message.checkAddrPattern("/tubeLines")) {
    String lineName = message.get(0).stringValue();  // getting name
    String lineColor =  message.get(1).stringValue();  // getting color
    lines.add(new Line(lineName, lineColor));
  }


  if (message.checkAddrPattern("/tubeStops")) {
    String data = message.get(0).stringValue();
    JSONObject json = parseJSONObject(data);

    float lat = json.getFloat("lat");
    float lon = json.getFloat("lon");
    JSONArray linesJSON = json.getJSONArray("lines");

    for (int i=0; i<linesJSON.size(); i++) {
      // add stops in lines
      for (Line l : lines) {
        String passingLineName = linesJSON.getString(i);
        if (l.name.equals(passingLineName)) {    // this is different from if(l.name==passingLineName). Maybe, quatation 
          l.addStop(lat, lon);
        }
      }
    }
  }
}

class Line {
  String name;
  color lineColor;
  ArrayList<PVector> stops  = new ArrayList<PVector>();

  Line(String name, String lineColor) {
    this.name = name;
    this.lineColor = unhex("88" + lineColor.substring(1));
    println("added " + this.name + "("+ lineColor +")");
  }

  void addStop(float lat, float lon) {
    stops.add(new PVector(lon, lat));
    println("added stop data to "+name+" : "+lon, lat);
  }

  void draw() {
    for (PVector s : stops) {
      fill(lineColor);
      float x = map(s.x, -0.65, 0.28, -width/2, width/2);
      float y = map(s.y, 51.75, 51.3, -height/2, height/2); 
      ellipse(x, y, stopRadius, stopRadius);
    }
  }
}
