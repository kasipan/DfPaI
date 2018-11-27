// interact to sound
import processing.sound.*;

AudioIn audio;
FFT fft;
int numBins = 256;
float[] spectrum = new float[numBins];


float rotation = 0;
int numRows = 80;
int dotsPerRow = 100;
PVector[] positions;
PVector[] randomPoints;

float rowSpacing = 10;
float sideLength = rowSpacing * (numRows - 1);
float halfSideLength = sideLength / 2;
float circleRadius = 215;
float sphereYOffset = 300;
float sphereFraction = 0.91;
float minYPos = 0;

// place points in rows and around a sphere
void generate() {
  for (int rowNumber = 0; rowNumber < numRows; rowNumber++) {
    for (int j = 0; j < dotsPerRow; j++) {
      float x = rowNumber * rowSpacing;
      float y = 0;
      //float z = random(0, sideLength);
      float z = randomGaussian() * halfSideLength * 0.4 + halfSideLength;

      float d = dist(x, z, halfSideLength, halfSideLength);
      if (d < circleRadius) {
        float h = sqrt(circleRadius * circleRadius - d * d);
        if (d > circleRadius * sphereFraction && random(1) < 0.2) {
          y = h - sphereYOffset;
        } else {
          y = -h - sphereYOffset;
        }
      }

      int index = rowNumber * dotsPerRow + j;
      positions[index] = new PVector(x, y, z);
    }
  }
}

// returns random points for each point in positions
PVector[] generateRandomPoints() {
  PVector[] points = new PVector[positions.length];
  for (int i = 0; i < positions.length; i++) {
    float x = random(sideLength);
    float y = -random(sideLength);
    float z = random(sideLength);
    points[i] = new PVector(x, y, z);
  }
  return points;
}

void setup() {
  size(512, 512, P3D);
  noStroke();
  fill(50);

  audio = new AudioIn(this, 0);
  audio.start();

  fft = new FFT(this, numBins);
  fft.input(audio);

  positions = new PVector[numRows * dotsPerRow];

  generate();

  randomPoints = generateRandomPoints();
}

void draw() {

  background(210);
  translate(width / 2, height / 2 + 220, 0);
  scale(0.6, 0.6, 0.6);

  rotateY(radians(rotation));
  translate(-halfSideLength, 0, -halfSideLength);

  //float q = map(mouseX, 0, width, 0, 1);

  fft.analyze(spectrum);
  //  println(spectrum[0]);
  float q = map(spectrum[0]*200, 0, 10, 0, 1); 


  for (int i = 0; i < positions.length; i++) {
    pushMatrix();
    PVector a = positions[i];
    PVector b = randomPoints[i];
    float x = lerp(a.x, b.x, q);
    float y = lerp(a.y, b.y, q);
    float z = lerp(a.z, b.z, q);

    translate(x, y, z);
    box(2);
    popMatrix();
  }

  rotation += 0.1;
}

void keyPressed() {
  //goRandom();
}
