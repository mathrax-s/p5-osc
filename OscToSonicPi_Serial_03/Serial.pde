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

  String stringData=myPort.readStringUntil(10);

  if (stringData!=null) {
    stringData=trim(stringData);
    int microbitData[]=int(split(stringData, ','));

    if (microbitData.length>3) {

      x=microbitData[0];
      y=microbitData[1];
      z=microbitData[2];

      //println(x + "\t"+y+ "\t"+z);
    }
  }
}