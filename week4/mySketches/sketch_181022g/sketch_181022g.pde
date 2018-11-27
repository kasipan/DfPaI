import websockets.*;
WebsocketServer server;
float x, y;

//         key, value
HashMap<String, PVector> positions = new HashMap<String, PVector>();

void setup() {
  size(500, 500);
  server = new WebsocketServer(this, 9999, "/data");
}

void draw() {
  background(0);
  for (HashMap.Entry entry : positions.entrySet()) {
    PVector pos = (PVector) entry.getValue();
    ellipse(pos.x, pos.y, 10, 10);
  }
}

void webSocketServerEvent(String msg) {
  println(msg);

  try {
    String[] parts = split(msg, ',');
    String id = parts[0];
    float x = float(parts[1]);
    float y = float(parts[2]);
    x %= width;
    y %= height;

    if (positions.containsKey(id)) {
      PVector pos = (PVector) positions.get(id);
      pos.x = x;
      pos.y = y;
      println(x,y);
    } else {
      positions.put(id, new PVector(x, y));
    }
  }
  catch (Exception e){
  }
}
