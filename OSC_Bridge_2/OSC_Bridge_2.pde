//micro:bitとProcessingでシリアル通信し
//SonicPiへOSC送信する

boolean serialPortSelect;
int selectSerialPortNum;
boolean debug=true;

float x;
float y;
float z;

////白い鍵盤の明るさとX座標
//float[] white_bright = new float[8];
//int[] white_x = {0, 100, 200, 300, 400, 500, 600, 700};

////黒い鍵盤の明るさとX座標
//float[] black_bright = new float[5];
//int[] black_x = {50, 150, 350, 450, 550};


int[]   key_x    = {0, 50, 100, 150, 200, 300, 350, 400, 450, 500, 550, 600, 700};
float[] bright   = new float[13];
int[]   note     = {72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84};
int[]   key_order = {0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0};
char[]  key_asign = {'z','s','x','d','c','v','g','b','h','n','j','m',','};

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
  for (int i=0; i<13; i++) {
    if (key_order[i]==0) {
      fill(255*(1.0-bright[i]));
      rect(key_x[i], 0, 95, 400, 4);
    }
  }
  //黒い鍵盤の表示
  for(int i=0; i<13; i++){
    if(key_order[i]==1){
      fill(55+200*bright[i]);
      rect(key_x[i], 0, 75, 240, 4);
    }
  }
  
  
  //micro:bitの加速度Xを0〜13に整える（0〜13の範囲を振り切る場合がある）
  x = map(mouseX, 0, width, 0, 13);
  //xxに、xを必ず0〜13の範囲に限定した値を入れる
  int xx = (int)constrain(x, 0, 13);

  //すべての鍵盤の判定
  for(int i=0; i<13; i++){
    //iが、加速度Xを整えた値xxと一致したら
    if (i==xx) {
      //キーの明るさを1.0に
      bright[xx] = 1.0;
      //SonicPiへ音階を送る
      sendOscSonicPi(note[xx]);
    } else {
      bright[i] *= 0.9;
    }
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
  //キーをチェックする
  for(int i=0; i<13; i++){
    //割り当てたキーが押されたら
    if(key==key_asign[i]){
      bright[i]=1.0;
      sendOscSonicPi(note[i]);
    }
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