int midiNote;


void setup() {
  size(600, 600);
  oscOpen();
}

void draw() {
  background(30,10,255);
}


void keyPressed() {
  if (key == 'a') {
    midiNote = 60;
  }
  if (key == 's') {
    midiNote = 62;
  }
  if (key == 'd') {
    midiNote = 64;
  }
  if (key == 'f') {
    midiNote = 65;
  }
  if (key == 'g') {
    midiNote = 67;
  }
  if (key == 'h') {
    midiNote = 69;
  }
  if (key == 'j') {
    midiNote = 71;
  }
  if (key == 'k') {
    midiNote = 72;
  }
  if(key == 'l'){
    midiNote = 74;
  }
  if(key == ';'){
    midiNote = 77;
  }

  sendOscSonicPi(midiNote+12);
}