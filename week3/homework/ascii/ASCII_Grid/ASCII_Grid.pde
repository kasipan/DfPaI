import processing.video.*;
Movie myMovie;
float[] THRESHOLD = {90, 60, 30};


void setup() {
  size(298, 50);
  colorMode(HSB, 360, 100, 100);
  myMovie = new Movie(this, "sample.mov");
  myMovie.loop();
}


void draw() {
  PImage frame = myMovie.get();
  image(frame, 0, 0);  // in order to avoid uncomprehensive error of resizing, I need to draw image?
  frame.loadPixels();
  frame.resize(298, 25);
  //frame.resize(myMovie.width, int(myMovie.height*0.5) );  // often the parameter cannot be allowed...

  
  String charsList = "";
  for (int y = 0; y < frame.height; y++) {    
    for (int x = 0; x < frame.width; x++) {
      // Calculate the 1D location from a 2D grid
      int loc = x + y * frame.width; 
      //int r = (frame.pixels[loc] >> 16) & 0xFF;
      //int g = (frame.pixels[loc] >> 8) & 0xFF;
      //int b = frame.pixels[loc] & 0xFF;
      //float h = hue(frame.pixels[loc]);
      //float s = saturation(frame.pixels[loc]);
      float v = brightness(frame.pixels[loc]);

      if (THRESHOLD[0] < v) {
        charsList += " ";
      } else if (THRESHOLD[1] < v) {
        charsList += ".";
      } else if (THRESHOLD[2] < v) {
        charsList += "s";
      } else {
        charsList += "&";  // darkest
      }
    }
    charsList += "\n";
  }
  println(charsList + "\n\n\n\n");
}


// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}
