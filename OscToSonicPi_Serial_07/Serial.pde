//Serial Communication

import processing.serial.*;
Serial myPort;

//USB-DEVICE
String portName = "usb";
int portNumber;


void serialOpen() {
  findSerialPort(); 
  myPort = new Serial(this, Serial.list()[portNumber], 115200); 
  myPort.setDTR(true);
  delay(1000);
  myPort.clear();
}

void findSerialPort() {
  String[] serialString;  
  int serialCount = 0;
  boolean firstContact = false; 
  String serialCheck;  
  int serialIndex;  
  int unknown;

  unknown=0;
  serialString = Serial.list();  
  for (int i = serialString.length - 1; i > 0; i--) {  
    serialCheck = serialString[i];  
    serialIndex = serialCheck.indexOf(portName);  
    if (serialIndex > -1) {
      portNumber = i;
    } else {
      unknown=1;
    }
  }
  println(Serial.list());
}


int x, y, z;

void serialEvent (Serial p) {

  if (myPort.available()>0) {
    int inByte = myPort.read();

    //println(inByte);
    if (inByte=='0') {
      bright[0] = 1.0;
      sendOscSonicPi(12+72);
    }
    if (inByte=='1') {
      bright[1] = 1.0;
      sendOscSonicPi(14+72);
    }
    if (inByte=='2') {
      bright[2] = 1.0;
      sendOscSonicPi(16+72);
    }
  }
}