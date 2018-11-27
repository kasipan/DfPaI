import netP5.*;
import oscP5.*;

class Particle {
  float angle, radius;
  float rotationSpeed;
  PVector amts;
  String name;

  Particle(String name, float radius, float speed) {
    this.name = name;
    angle = random(0, TWO_PI);
    this.radius = radius;
    rotationSpeed = speed;
    amts = new PVector(random(1), random(1), random(1));
  }

  void update() {
    angle += rotationSpeed;
  }

  void draw() {
    pushMatrix();
    rotateX(angle * amts.x);
    rotateY(angle * amts.y);
    rotateZ(angle * amts.z);
    translate(radius, 0, 0);
    rotateZ(-angle * amts.z);
    rotateY(-angle * amts.y);
    rotateX(-angle * amts.x);
    rotateY(-rotationY);
    text(name, 0, 0);
    popMatrix();
  }
}

float rotationY = 0;
ArrayList<Particle> particles = new ArrayList<Particle>();
OscP5 oscP5;

void setup() {
  size(500, 500, P3D);

  oscP5 = new OscP5(this, 2345);

  noStroke();
}

void draw() {
  background(0);
  lights();

  translate(width / 2, height / 2);
  rotationY = map(mouseX, 0, width, 0, TWO_PI);
  rotateY(rotationY);
  scale(mouseY * 0.01, mouseY * 0.01, mouseY * 0.01);

  try {
    for (Particle particle : particles) {
      particle.update();
      particle.draw();
    }
  }
  catch (Exception e) {
  }
}

void oscEvent(OscMessage message) {
  String name = message.get(0).stringValue();
  particles.add(new Particle(name, 200, 0.01));
}
