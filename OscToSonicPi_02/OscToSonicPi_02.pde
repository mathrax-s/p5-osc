int midiNote;

float[] bright = new float[10];
int i;


void setup() {
  size(600, 600);
  oscOpen();
  for (i=0; i<10; i++) {
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
    //rect(60*i, 0, 60, 600*bright[i]);
    rect(60*i, 600*bright[i], 60, 600*bright[i]);
  }
}


void keyPressed() {
  if (key == 'a') {
    midiNote = 60;
    bright[0] = 1.0;
  }
  if (key == 's') {
    midiNote = 62;
    bright[1] = 1.0;
  }
  if (key == 'd') {
    midiNote = 64;
    bright[2] = 1.0;
  }
  if (key == 'f') {
    midiNote = 65;
    bright[3] = 1.0;
  }
  if (key == 'g') {
    midiNote = 67;
    bright[4] = 1.0;
  }
  if (key == 'h') {
    midiNote = 69;
    bright[5] = 1.0;
  }
  if (key == 'j') {
    midiNote = 71;
    bright[6] = 1.0;
  }
  if (key == 'k') {
    midiNote = 72;
    bright[7] = 1.0;
  }
  if(key == 'l'){
    midiNote = 74;
    bright[8] = 1.0;
  }
  if(key == ';'){
    midiNote = 77;
    bright[9] = 1.0;
  }

  sendOscSonicPi(midiNote+12);
}