import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

//OSC通信を始める
void oscOpen() {
  //ProcessingのOSC受信ポート（今回はOSC受信しないがこのプログラムでは必要になる）
  oscP5 = new OscP5(this, 50000);
  
  //ProcessingからOSC送信,SonicPiがOSC受信するポート
  //SonicPiの受信ポートは、4559と決まっている
  myRemoteLocation = new NetAddress("localhost", 4559);
}


//SonicPiへOSC送信する
void sendOscSonicPi(int note) {
  //OSCメッセージを作る
  OscMessage myMessage = new OscMessage("/ch0/note");
  //このメッセージにnoteを追加する
  myMessage.add(note); 
  //OSCメッセージを、myRemoteLocation宛てに送る
  oscP5.send(myMessage, myRemoteLocation);
}


//以下のコードをSonicPiにコピーする
/*
##ここから
 live_loop :synth do
 use_real_time
 a = sync "/osc/ch0/note"
 synth :beep, note: a,  release: 0.5
 end
##ここまで 
 */