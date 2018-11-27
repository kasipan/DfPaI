//Instructions: Drag mouse along the width to change the threshold used for the masking process
 
PImage img, mimg;
PImage bimg;
int[] mmask;
 
void settings() {
  img = loadImage("https://"+"cdn.shutterstock.com/shutterstock/videos/2582822/thumb/1.jpg");
  size(img.width, img.height);
}
 
void setup() {
  bimg=loadImage("http://"+"lonelyplanet.es/img/uploads/images/senjo-ji-tokio.jpg");
  bimg.resize(width, height);
  mmask=new int[width*height];
}
 
void draw() {
 
  img.loadPixels();
  for (int i=0; i<width*height; i++) {
    int greenn=(img.pixels[i]>>8) & 0xff;    
    int redd=(img.pixels[i]>>16) & 0xff;
    int bluee=img.pixels[i] & 0xff;
 
    float thresh=map(mouseX,0,width,0,255);    
    float d=dist(redd,greenn,bluee,0,250,0);
 
    ////APPROACH #1: Testing only for green. Not perfect
    //if (greenn>thresh )
    ////APPROACH #2: Testing the boundary of green. Better performance
    if(d<thresh)
      mmask[i]=0;
    else
      mmask[i]=255;
  }
  mimg=img.get();
 
  // This is the command that doesn't seem to work!
  mimg.mask(mmask);
  image(bimg, 0, 0);
  image(mimg, 0, 0);
}
