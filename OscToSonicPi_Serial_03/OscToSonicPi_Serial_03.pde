float mX;
float mY;
float mZ;

float[] bright = new float[10];
int i;
int[] notes ={2,4,7,9,11, 14,16,19,21,23, 26,28,31,33,35};

void setup() {
  size(600, 600);
  serialOpen();
  oscOpen();
  for(i=0; i<10; i++){
    bright[i] = 0;
  }
  noStroke();
  colorMode(HSB);
}

void draw() {
  background(30,10,255);
  
  for(i=0; i<10; i++){
    bright[i]*=0.9;
    fill(i*10,100,255, 255);
    rect(60*i, 600*bright[i], 60, 600*bright[i]);
  }
  

  mX = map(x, -1023, 1023, 0, 9); 
  mY = map(y, -1023, 1023, 0, 9); 
  mZ = map(z, -1023, 1023, 0,100);
  

  if(mZ>25){
    if(mX<0)mX=0;
    if(mX>9)mX=9;
    bright[int(mX)]=1.0;
    sendOscSonicPi(notes[int(mX)]+72);
  }
  
  //textAlign(CENTER,CENTER);
  //textSize(24);
  //text(int(mX), 200,400);
  //text(int(mY), 300,400);
  //text(int(mZ), 400,400);
  
}