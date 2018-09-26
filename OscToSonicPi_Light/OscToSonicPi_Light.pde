// Visual Synth Demo
// 2018.6.9

float mX;
float mY;
float mZ;
int maxNum=100;
float[] bright = new float[maxNum];
int[] keys = {'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';'};
int[] notes ={2, 4, 7, 9, 11, 14, 16, 19, 21, 23, 26, 28, 31, 33, 35};

Light[] lt=new Light[maxNum];
int lt_count;
boolean serialPortSelect;
int selectSerialPortNum;
boolean debug=false; //true or false

void setup() {
  size(800, 600);
  //fullScreen();

  //シリアルポートを探す
  searchSerialPort();
  oscOpen();

  for (int i=0; i<maxNum; i++) {
    bright[i] = 0;
    lt[i] = new Light(0, 0, color(0));
  }

  noStroke();
  colorMode(HSB);
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
  
  colorMode(RGB);
  //background(230,235,220);
  background(0);
  for (int i=0; i<maxNum; i++) {
    lt[i].draw();
  }

  mX = map(microbitData[0], -1023, 1023, 0, 9); 
  mY = map(microbitData[1], 0, 1023, 0, 9); 
  mZ = map(microbitData[2], -1023, 1023, 0, 100);
  
  mX = constrain(mX,0,9);
  mY = constrain(mY,0,9);
  mZ = constrain(mZ,0,100);
  
  //Sensor Check
  if (microbitData[3]==1) {
    //if (mY<0)mY=0;
    //if (mY>9)mY=9;
    int nx = (int)mX;
    int ny = (int)mY;
    int nz = (int)mZ;
    bright[ny] = 1.0;
    lt_count++;
    if (lt_count>=maxNum)lt_count=0;
    lt[lt_count].on((width/10)*ny, height*bright[ny], color(ny*10, 150, 255,255));
    sendOscSonicPi(notes[ny]+72, nx, nz);
  }

  //Debug
  //textAlign(CENTER, CENTER);
  //textSize(24);
  //fill(255, 255, 255);
  //text(int(mX), 200, 400);
  //text(int(mY), 300, 400);
  //text(int(mZ), 400, 400);
}

//Key Simulation
void keyPressed() {
  for (int i=0; i<10; i++) {
    if (key == keys[i]) {
      bright[i] = 1.0;
      lt_count++;
      if (lt_count>=100)lt_count=0;
      lt[lt_count].on((width/10)*i, height*bright[i], color(i*10, 150, 255, 255));
      sendOscSonicPi(notes[i]+72, 5,50);
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