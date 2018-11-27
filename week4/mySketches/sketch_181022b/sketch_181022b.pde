// cubes interacting to audio
import processing.sound.*;
int numBins = 128;
AudioIn audio;
FFT fft;
float[] spectrum = new float[numBins];
float volume;

class Particle {
  float angle, radius;
  float rotationSpeed;
  PVector amts;

  Particle(float radius, float speed) {
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
    translate(radius+volume, 0, 0);
    //rotateZ(-angle * amts.z);
    //rotateY(-angle * amts.y);
    //rotateX(-angle * amts.x);
    //rotateY(-rotationY);
    fill(255);
    box(volume);
    popMatrix();
  }
}

float rotationY = 0;
ArrayList<Particle> particles = new ArrayList<Particle>();

void setup() {
  size(500, 500, P3D);

  
  noStroke();
  for(int i=0;i<200;i++){
    particles.add(new Particle(200, 0.01));
  }

  audio = new AudioIn(this, 0);
  audio.start();

  fft = new FFT(this, numBins);
  fft.input(audio);
}

void draw() {
  //background(0,0.2);
  lights();
  
  fft.analyze(spectrum);
  volume = spectrum[0]* 5 * 500;
  
  translate(width / 2, height / 2);
  rotationY = map(mouseX, 0, width, 0, TWO_PI);
  //rotateY(rotationY);
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
