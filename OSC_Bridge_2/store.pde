//microbitからのデータを格納する
int[] microbitData = new int[5];

void storeData(int[] buff) {
  //bufferのデータが3個揃ったなら、
  if (buff.length>=5) {
    //microbitDataに格納する
    microbitData[0] = buff[0];
    microbitData[1] = buff[1];
    microbitData[2] = buff[2];
    microbitData[3] = buff[3];
    microbitData[4] = buff[4];
  }
}