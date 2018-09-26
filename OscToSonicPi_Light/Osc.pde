import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void oscOpen() {
  oscP5 = new OscP5(this, 50000);
  myRemoteLocation = new NetAddress("localhost", 4559);
}

void sendOscSonicPi(int a, int b, int c){
  OscMessage myMessage = new OscMessage("/ch0/note");
  myMessage.add(a); 
  myMessage.add(b); 
  myMessage.add(c); 
  oscP5.send(myMessage, myRemoteLocation);
}

/*
##| SonicPi Code
live_loop :zoo do
  use_real_time
  a = sync "/osc/trigger/channel0"
  synth :beep, note: a,  release: 0.5
end
*/