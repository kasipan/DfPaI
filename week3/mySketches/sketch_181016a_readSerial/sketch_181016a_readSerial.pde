import processing.serial.*;

Serial port;

void setup() {
  size(500, 500);
  port=new Serial(this, "/dev/XXXX");
}

void draw() {
  if (port.available()>0) {
    String line = port.readString();
    String stripped_line = trim(line);
    println(stripped_line);
    background(int(stripped_line)/4);
  }
}
