/* 
 Run this code, then run sendJson.py
 */

import netP5.*;
import oscP5.*;

OscP5 oscP5;
ArrayList<Line> lines  = new ArrayList<Line>();
float mouseRange = 10;

void setup() {
  size(700, 700);
  //blendMode(ADD);


  oscP5 = new OscP5(this, 5000);
}

void draw() {
  background(255);

  try {
    for (Line l : lines) {
      for (Stop s : l.stops) {
        if (dist(s.pos.x, s.pos.y, mouseX, mouseY) < mouseRange) {
          l.vibe = 8;
        }
      }
      l.update();
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
  ArrayList<Stop> stops  = new ArrayList<Stop>();
  float stopRadius = 5;
  float vibe = 0;

  Line(String name, String lineColor) {
    this.name = name;
    this.lineColor = unhex("88" + lineColor.substring(1));  // convert string data to color with alpha
    println("added " + this.name + "("+ lineColor +")");
  }

  void addStop(float lat, float lon) {
    float x = map(lon, -0.65, 0.28, 0, width);
    float y = map(lat, 51.75, 51.3, 0, height);
    stops.add(new Stop(x, y));
    println("added stop's data to " + name + " : " + x, y + "(" + lon, lat + ")");
  }

  void draw() {
    float stopsNum = stops.size();
    for (int i=0; i<stopsNum; i++) {
      PVector sbj_pos = stops.get(i).pos; 
      noStroke();
      fill(lineColor);
      ellipse(sbj_pos.x, sbj_pos.y, stopRadius, stopRadius);

      for (int j=i+1; j<stopsNum; j++) {
        PVector cmp_pos = stops.get(j).pos;
        float dist = dist(sbj_pos.x, sbj_pos.y, cmp_pos.x, cmp_pos.y);
        if (dist < width/3) {    // threshold to decrease mesh
          float boldness = 50/dist;  // further distance makes lighter
          if (boldness < 25) {  // threshold to decrease too strong lines
            strokeWeight(boldness);
            stroke(lineColor);
            line(sbj_pos.x, sbj_pos.y, cmp_pos.x, cmp_pos.y);
          }
        }
      }
    }
  }

  void update() {
    if (vibe >= 0) {
      for (Stop s : stops) {
        //println(noise(abs(10/(s.pos.x-mouseX))));
        //s.pos.x = s.pos_org.x + vibe*(0.5-noise(abs(10/(s.pos.x-mouseX))));
        //s.pos.y = s.pos_org.y + vibe*(0.5-noise(abs(10/(s.pos.y-mouseY))));
        s.pos.x = s.pos_org.x + (random(-vibe, vibe)+random(-vibe, vibe)+random(-vibe, vibe)+random(-vibe, vibe))/4.0f;  // make smoothness
        s.pos.y = s.pos_org.y + (random(-vibe, vibe)+random(-vibe, vibe)+random(-vibe, vibe)+random(-vibe, vibe))/4.0f;
      }
      
      vibe -= 0.1;
    }
  }
}


class Stop{
  PVector pos_org, pos;
  //float vibe = 0;
  
  Stop(float x, float y){
    pos_org = new PVector(x, y);
    pos = pos_org;
  }
}
