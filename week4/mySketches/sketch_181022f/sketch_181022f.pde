import websockets.*;
WebsocketServer server;
float x,y;

void setup() {
  size(500, 500);
  server = new WebsocketServer(this, 9999, "/data");
}

void draw() {
  background(0);
  ellipse(x,y,10,10);
}

void webSocketServerEvent(String msg){
  println(msg);
  String[] parts = split(msg,',');
  x = float(parts[0]);
  y = float(parts[1]);
  x %= width;
  y %= height;
}
