// Visual Synth Demo
// 2018.6.9

float mX;
float mY;
float mZ;
float[] bright = new float[10];
int[] keys = {'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';'};
int[] notes ={2, 4, 7, 9, 11, 14, 16, 19, 21, 23, 26, 28, 31, 33, 35};

Light[] lt=new Light[10];
int lt_count;

void setup() {
  size(600, 600);

  noCursor();
  serialOpen();
  oscOpen();

  for (int i=0; i<10; i++) {
    bright[i] = 0;
    lt[i] = new Light(i*100, 0, color(i*10, 150, 255, 255));
  }
  x=-1023;
  y=-1023;
  z=-1023;

  noStroke();
  colorMode(HSB);
}

void draw() {
  //background(30, 40, 255);
  background(0);
  for (int i=0; i<10; i++) {
    //bright[i]*=0.9;
    //fill(i*10, 150, 255, 255);
    //rect((width/10)*i, height*bright[i], (width/10), height*bright[i]);
    lt[i].draw();
  }

  //mX = map(x, -1023, 1023, 0, 9); 
  //mY = map(y, -1023, 1023, 0, 9); 
  //mZ = map(z, -1023, 1023, 0, 100);

  ////Sensor Check
  //if (mZ>25) {
  //  if (mX<0)mX=0;
  //  if (mX>9)mX=9;
  //  bright[(int)(mX)]=1.0;
  //  sendOscSonicPi(notes[(int)(mX)]+72);
  //  z=-1023;
  //}

  //Debug
  //textAlign(CENTER,CENTER);
  //textSize(24);
  //text(int(mX), 200,400);
  //text(int(mY), 300,400);
  //text(int(mZ), 400,400);
}

//Key Simulation
void keyPressed() {
  for (int i=0; i<10; i++) {
    if (key == keys[i]) {
      bright[i] = 1.0;
      lt_count++;
      if (lt_count>=10)lt_count=0;
      lt[lt_count].on((width/10)*i, height*bright[i], color(i*10, 150, 255, 255));
      sendOscSonicPi(notes[i]+72);
    }
  }
}
