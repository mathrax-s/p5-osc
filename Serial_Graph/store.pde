//microbitからのデータを格納する
int[] microbitData = new int[1];

void storeData(int[] buff) {
  for (int i=0; i<buff.length; i++) {

    //もしmicrobitDataの配列数が、buff配列数より小さいとき
    if (microbitData.length <= i) {

      //microbitDataの配列を追加し、buff配列を格納する
      microbitData = append(microbitData, buff[i]);
      
    //もしmicrobitDataの配列数が、buff配列数より大きいとき
    }else if (microbitData.length > buff.length){
      //microbitDataの配列を1つ減らす
      microbitData = shorten(microbitData);
      
    //そうでないとき
    }else{
      //microbitData配列にbuff配列を格納する
      microbitData[i] = buff[i];
    }
  }
}