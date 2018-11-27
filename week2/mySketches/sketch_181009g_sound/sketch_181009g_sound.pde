import processing.sound.*;

int numBins = 256;
AudioIn audio;
FFT fft;
float[] spectrum = new float[numBins];

void settings(){
  size(numBins*2, numBins*2);
}

void setup(){
  audio = new AudioIn(this, 0);  // this is a parent who call the function, channel
  audio.start();
  
  fft = new FFT(this, numBins);
  fft.input(audio);
}

void draw(){
  fft.analyze(spectrum);
  println(spectrum[0]);
  background(spectrum[0]*255*2);
  
}
