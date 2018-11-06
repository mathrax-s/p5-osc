boolean serialPortSelect;
int selectSerialPortNum;
boolean debug=false;

float x;
float y;
float z;

int ledData;
int motorData;

void setup() {
  size(200, 160);
  //シリアルポートを探す
  searchSerialPort();
  //OSC通信を始める
  oscOpen();

  textAlign(CENTER, CENTER);
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

void drawMain() {
  background(0);
  
  OscMessage myMessage = new OscMessage("/ch0/note");
  for (int i=0; i<microbitData.length-1; i++) {
    myMessage.add(microbitData[i]);
  }
  oscP5.send(myMessage, myRemoteLocation);

  fill(255,255,255);
  text("Serial OSC Simple", width/2, height/2-10);
  text("receive : 50000 port", width/2, height/2+10);
  text("send    :  4559 port", width/2, height/2+30);
}


//マウスクリックしたとき
void mousePressed() {
  //シリアルポート選択がまだの場合
  if (!serialPortSelect) {
    //シリアルポートを開く
    serialOpen(selectSerialPortNum);
    //シリアルポート選択した、と記憶する
    serialPortSelect=true;
    //画面を黒で消去
    background(0);
  } else {  //シリアルポート選択している場合

    //micro:bitからのデータが空の時
    if (microbitData==null) {
      //間違ったポートを開いたとみなし、いったんポートを閉じる
      serialClose();
      //シリアルポート未選択とする
      serialPortSelect=false;
      //画面を黒で消去
      background(0);
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
    textSize(10);
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