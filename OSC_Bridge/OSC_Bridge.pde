//micro:bitとProcessingでシリアル通信し
//SonicPiへOSC送信する

boolean serialPortSelect;
int selectSerialPortNum;
boolean debug=false;

//白い鍵盤の明るさとX座標
float[] white_bright = new float[8];
int[] white_x = {0, 100, 200, 300, 400, 500, 600, 700};

//黒い鍵盤の明るさとX座標
float[] black_bright = new float[5];
int[] black_x = {50, 150, 350, 450, 550};


void setup() {
  //画面サイズを800x600にする
  size(800, 400);
  //シリアルポートを探す
  searchSerialPort();
  //OSC通信を始める
  oscOpen();
}

void draw() {
  if (debug) {
    drawMain();
    return;
  }
  //シリアルポートを選んでない場合
  if (!serialPortSelect) {
    //シリアルポート選択画面を表示
    serialPortSelectScene();
    return;
  }

  //micro:bitからのデータが何かあれば、doMain()へ
  if (microbitData!=null) {
    drawMain();
  } else {
    //micro:bitからのデータが何もなければ「クリックして戻る」表示
    background(0);
    fill(255);
    text("No data...\r\n Click and back to select serialport.", width/2, height/2);
  }
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
  textAlign(RIGHT, CENTER);
  fill(50);
  rect(640, 330, 150, 45, 4);
  fill(255);
  text("Serial+OSC", 780, 350);
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

//マウスクリックしたとき
void mousePressed() {
  //シリアルポート選択がまだの場合
  if (!serialPortSelect) {
    //シリアルポートを開く
    serialOpen(selectSerialPortNum);
    //シリアルポート選択した、と記憶する
    serialPortSelect=true;
    //画面を白で消去
    background(255);
  } else {  //シリアルポート選択している場合

    //micro:bitからのデータが空の時
    if (microbitData==null) {
      //間違ったポートを開いたとみなし、いったんポートを閉じる
      serialClose();
      //シリアルポート未選択とする
      serialPortSelect=false;
      //画面を白で消去
      background(255);
    }
  }
}


//シリアルポートを選ぶ画面の表示
void serialPortSelectScene() {
  colorMode(RGB);
  background(0);
  selectSerialPortNum=-1;
  for (int i=0; i<serialString.length; i++) {
    int h = height/serialString.length;
    if (overRect(0, h*i, width, h)) {
      //
      noStroke();
      fill(255, 255, 255);
      selectSerialPortNum=i;
    } else {
      //
      stroke(100, 100, 100);
      noFill();
    }
    rect(0, h*i, width-1, h);

    if (selectSerialPortNum==i) {
      fill(0, 0, 0);
    } else {
      fill(255, 255, 255);
    }
    textAlign(CENTER, CENTER);
    textSize(20);
    text(serialString[i], width/2, h/2+h*i);
  }
}

//マウスが指定したエリア内に入ったかどうか調べる
boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}