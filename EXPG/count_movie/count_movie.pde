import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import oscP5.*;
import processing.video.*;
// シリアルライブラリを取り入れる
import processing.serial.*;
// myPort（任意名）というインスタンスを用意
Serial myPort;

Minim minim;  //Minim型変数であるminimの宣言
AudioPlayer player;  //サウンドデータ格納用の変数

Movie Movie1;
Movie Movie2;
float tm;
char flag = 'f';
boolean b = true;
boolean lb = true;

void setup(){
    fullScreen(P2D,2);
    minim = new Minim(this);  //初期化
    player = minim.loadFile("house.mp3");  //sample.mp3をロードする
    //size(1920,1080,P2D);
    // シリアルポートの設定
    // "/dev/tty.usbmodem1411" の部分を前述の「シリアルポートを選択する」で選択したシリアルポートにあわせて書き換える
    myPort = new Serial(this, "COM10", 19200);
    Movie1 = new Movie(this, "count_down.mp4");
    Movie2 = new Movie(this, "taiki.mp4");
}

void movieEvent(Movie m) {
m.read();
}

void draw(){
    tm = Movie1.time();
    int xm;
    int ym;
    background(0);
    if(!lb){
      xm = 1920;
      ym = 1080;
      image(Movie1,0,0,xm,ym);
      text(frameRate,200,200);
      text(tm, 100,100);
    }
    if(lb){
      xm = 1920;
      ym = 1080;
      image(Movie2,0,0,xm,ym);
    }
    if(tm >= 11.4){
      if(b){
      myPort.write(flag);
      b = !b;
      }
   
    }else{
      b = true;
    }
    if(tm >= 17.6){
       lb = true;
    Movie1.jump(0.0);
    Movie1.stop();
    Movie2.loop();
    player.play();  //再生
    player.loop();  //再生
   }   
}
void keyPressed(){
  if(key == 'a'){
    lb = !lb;
    Movie1.play();
    player.pause();
  }
  if(key == 'r'){
    lb = true;
    Movie1.jump(0.0);
    Movie1.stop();
    Movie2.loop();
    player.play();  //再生
    player.loop();  //再生
  }
}