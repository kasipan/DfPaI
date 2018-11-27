Table table;
ArrayList<Obj> objs = new ArrayList<Obj>();

void setup() {
  size(500, 500);
  fill(255);
  noStroke();

  table = loadTable("table.csv", "header");

  for (TableRow row : table.rows()) {
    String shape = row.getString("shape");
    float x = row.getFloat("x");
    float time = row.getFloat("time");
    
    objs.add(new Obj(shape, x, time));
  }
}


void draw() {
  background(0);
  for (Obj obj : objs) {
    obj.draw();
  }
}


class Obj {
  String shape;
  float x, y;
  float time;

  Obj(String shape, float x, float time) {
    this.shape = shape;
    this.x = x;
    this.y = -1;
    this.time = time;
  }

  void draw() {
    if (time*100>frameCount) {
      y++;
    }
    
    if (shape.equals("circle")) {
      ellipse(x, y, 10, 10);
    } else if (shape.equals("rect")) {
      rect(x, y, 10, 10);
    }
  }
}
