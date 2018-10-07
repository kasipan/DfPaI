int faceSize = 50;
PImage imgBook, imgFace;

void setup() {
  size(550, 550);
  imageMode(CENTER);
  imgBook = loadImage("books.png");
  imgFace = loadImage("face.png");
}

void draw() {
  background(0);

  for (int x=0; x<11; x++) {
    for (int y=0; y<11; y++) {
      smile((x+0.5)*faceSize, (y+0.5)*faceSize);
    }
  }
}

void smile(float x, float y) {
  if (x==width/2 && y==height/2) {
    //face
    image(imgFace, x, y, faceSize, faceSize);
  } else {
    image(imgBook, x, y, faceSize, faceSize);
  }
}

// This is me.
