const int led_pin1 = 13;           // LED1 connected to digital pin 13

void setup() {
pinMode(led_pin1, OUTPUT);
digitalWrite(led_pin1, LOW);    // 消灯
Serial.begin(19200);//シリアル通信速度設定
}
void loop() {
    // シリアル通信でデータが送られてくるまで待つ。
    if (Serial.available() > 0)
    {
    // 一文字分データを取り出す。
    char c = Serial.read();
    // fが送られてきたらLEDを点灯させる。
   if (c == 'f') {
digitalWrite(led_pin1, HIGH);   // 点灯
delay(200);
digitalWrite(led_pin1, LOW);    // 消灯
delay(100);          
}
}
}

