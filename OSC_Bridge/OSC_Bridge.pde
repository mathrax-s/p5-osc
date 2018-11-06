//ProcessingからSonicPiへOSC送信する

int[]   key_x    = {0, 50, 100, 150, 200, 300, 350, 400, 450, 500, 550, 600, 700};
int[]   key_order = {0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0};
float[] bright   = new float[13];


boolean debug=true;

void setup() {
  //画面サイズを800x400にする
  size(800, 400);
  //OSC通信を始める
  oscOpen();
}

void draw() {
  //if (debug) {
    drawMain();
    //return;
  //}
}


//画面を描画するプログラム
void drawMain() {
  //背景を黒に
  background(0, 0, 0);

  //白い鍵盤の表示
  for (int i=0; i<13; i++) {
    if (key_order[i]==0) {
      fill(255*(1.0-bright[i]));
      rect(key_x[i], 0, 95, 400, 4);
    }
  }
  //黒い鍵盤の表示
  for (int i=0; i<13; i++) {
    if (key_order[i]==1) {
      fill(55+200*bright[i]);
      rect(key_x[i], 0, 75, 240, 4);
    }
  }
  //すべての鍵盤の判定
  for (int i=0; i<13; i++) {
    bright[i] *= 0.9;
  }

  //文字表示
  textSize(24);
  textAlign(RIGHT, CENTER);
  fill(50);
  rect(720, 330, 70, 45, 4);
  fill(255);
  text("OSC", 780, 350);
}


//キーボードでSonicPiへOSC送信
void keyPressed() {
  if (key=='z') {
    bright[0]=1.0;
    sendOscSonicPi(72);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='s') {
    bright[1]=1.0;
    sendOscSonicPi(73);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='x') {
    bright[2]=1.0;
    sendOscSonicPi(74);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='d') {
    bright[3]=1.0;
    sendOscSonicPi(75);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='c') {
    bright[4]=1.0;
    sendOscSonicPi(76);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='v') {
    bright[5]=1.0;
    sendOscSonicPi(77);  //SonicPiへOSC送信（oscタブ内）
  }  
  if (key=='g') {
    bright[6]=1.0;
    sendOscSonicPi(78);  //SonicPiへOSC送信（oscタブ内）
  }  
  if (key=='b') {
    bright[7]=1.0;
    sendOscSonicPi(79);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='h') {
    bright[8]=1.0;
    sendOscSonicPi(80);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='n') {
    bright[9]=1.0;
    sendOscSonicPi(81);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='j') {
    bright[10]=1.0;
    sendOscSonicPi(82);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='m') {
    bright[11]=1.0;
    sendOscSonicPi(83);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key==',') {
    bright[12]=1.0;
    sendOscSonicPi(84);  //SonicPiへOSC送信（oscタブ内）
  }
}