//ProcessingからSonicPiへOSC送信する

//白い鍵盤の明るさとX座標
float[] white_bright = new float[8];
int[] white_x = {0, 100, 200, 300, 400, 500, 600, 700};

//黒い鍵盤の明るさとX座標
float[] black_bright = new float[5];
int[] black_x = {50, 150, 350, 450, 550};


void setup() {
  //画面サイズを800x600にする
  size(800, 400);
  //OSC通信を始める
  oscOpen();
}

void draw() {
    if(saveOneFrame == true) {
    beginRecord(PDF, "Line.pdf"); 
  }
  drawMain();
    if(saveOneFrame == true) {
    endRecord();
    saveOneFrame = false; 
  }
}

import processing.pdf.*;
boolean saveOneFrame = false;
void mousePressed() {
  saveOneFrame = true; 
}


//画面を描画するプログラム
void drawMain() {
  //背景を黒に
  background(0, 0, 0);

  //白い鍵盤の表示
  for (int i=0; i<8; i++) {
    white_bright[i]*=0.9;
    fill(255*(1.0-white_bright[i]));
    rect(white_x[i], 0, 95, 400, 4);
  }

  //黒い鍵盤の表示
  for (int i=0; i<5; i++) {
    black_bright[i]*=0.9;
    fill(55+200*black_bright[i]);
    rect(black_x[i], 0, 95, 240, 4);
  }
  
  //文字表示
  textSize(24);
  textAlign(RIGHT,CENTER);
  fill(50);
  rect(720,330,70,45,4);
  fill(255);
  text("OSC", 780,350);
}


//キーボードでSonicPiへOSC送信
void keyPressed() {
  //白い鍵盤のキー
  if (key=='a') {
    white_bright[0]=1.0;
    sendOscSonicPi(72);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='s') {
    white_bright[1]=1.0;
    sendOscSonicPi(74);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='d') {
    white_bright[2]=1.0;
    sendOscSonicPi(76);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='f') {
    white_bright[3]=1.0;
    sendOscSonicPi(77);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='g') {
    white_bright[4]=1.0;
    sendOscSonicPi(79);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='h') {
    white_bright[5]=1.0;
    sendOscSonicPi(81);  //SonicPiへOSC送信（oscタブ内）
  }  
  if (key=='j') {
    white_bright[6]=1.0;
    sendOscSonicPi(83);  //SonicPiへOSC送信（oscタブ内）
  }  
  if (key=='k') {
    white_bright[7]=1.0;
    sendOscSonicPi(84);  //SonicPiへOSC送信（oscタブ内）
  }

  //黒い鍵盤のキー
  if (key=='w') {
    black_bright[0]=1.0;
    sendOscSonicPi(73);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='e') {
    black_bright[1]=1.0;
    sendOscSonicPi(75);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='t') {
    black_bright[2]=1.0;
    sendOscSonicPi(78);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='y') {
    black_bright[3]=1.0;
    sendOscSonicPi(80);  //SonicPiへOSC送信（oscタブ内）
  }
  if (key=='u') {
    black_bright[4]=1.0;
    sendOscSonicPi(82);  //SonicPiへOSC送信（oscタブ内）
  }
}
