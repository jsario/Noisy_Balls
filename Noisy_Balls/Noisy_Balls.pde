import processing.sound.*;

SoundFile file;
Sphere[] balls = new Sphere[80];
int[] box = {200, 700, 300, 1000, 100, 500};
float x;
float y;
float z;
float size;
int count = 10;
PFont f;
boolean mute;
String[] sounds = {"fingers.mp3", "can.mp3", "door.mp3", "bag.mp3", "spoon.mp3", "coins.mp3"};

void setup(){
  f = createFont("Ariel", 25, true);
  fullScreen(P3D);
  background(0);
  for(int i = 0; i < count; i++){
    createSphere(i);
  }
  // Load a soundfile from the data folder of the sketch and play it back in a loop
  file = new SoundFile(this, "ac.mp3");
  file.loop();
  mute = false;
}

void draw(){
  background(0);
  for(Sphere ball : balls){
    if(ball != null){
      ball.update();
      ball.display();
      ball.checkBoundaryCollision(mute);
    }
  }
  
  if (mousePressed) {
    if (mouseButton == LEFT && count < balls.length) {
      createSphere(count);
      count += 1;
    }
    else if(mouseButton == RIGHT && count > 0){
      balls[count-1] = null;
      count -= 1;
    }
  }
  //checkHits();
  
  if(keyPressed) {
    if (key == ESC) {
      exit();
    }
    else if (key == 'M' || key == 'm'){
      if (mute) {
        mute = false;
        file.loop();
      }
      else {
        mute = true;
        file.stop();
      }
    }
  }
  
  textFont(f);
  fill(255, 0, 0);
  textAlign(CENTER);
  text("Left click to add balls, Max:40. Right click to remove balls. ESC to exit. 'M' key to turn off sound.", 
      width/2, 700);
  fill(0, 250, 0);
  text("Current: " + count, width/2, 750);
}

void createSphere(int i) {
  x = random(225, 1000);
  y = random(225, 700);
  z = random(175, 400);
  size = random(10, 40);
  SoundFile sound = new SoundFile(this, sounds[i % sounds.length]);
  balls[i] = new Sphere(x, y, z, size, box, i, sound);
}

void checkHits(){
   for(int i = 0; i < count; i++){
     Sphere first = balls[i];
     if(first != null){
       for(int k = 1; k < count; k++){
         Sphere second = balls[k];
         if(second != null){
           first.checkCollision(second);
         }
       }
     }
   }
}