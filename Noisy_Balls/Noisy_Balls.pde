Sphere[] balls = new Sphere[40];
int[] box = {200, 700, 300, 1000, 100, 500};
float x;
float y;
float z;
float size;
int count = 20;
PFont f;

void setup(){
  f = createFont("Ariel", 25, true);
  fullScreen(P3D);
  background(0);
  for(int i = 0; i < count; i++){
    x = random(225, 1000);
    y = random(225, 700);
    z = random(175, 400);
    size = random(10, 40);
    balls[i] = new Sphere(x, y, z, size, box, i);
  }
}

void draw(){
  background(0);
  for(Sphere ball : balls){
    if(ball != null){
      ball.update();
      ball.display();
      ball.checkBoundaryCollision();
    }
  }
  if(mousePressed && (mouseButton == LEFT) && count < balls.length){
    x = random(200, 1000);
    y = random(200, 750);
    z = random(150, 400);
    size = random(10, 40);
    balls[count-1] = new Sphere(x, y, z, size, box, count-1);
    count += 1;
    if(count > 50){
      count = 50;
    }
  }
  if(mousePressed && (mouseButton == RIGHT) && count > 0){
    balls[count-1] = null;
    count -= 1;
    if(count < 0){
      count = 0;
    }
  }
  checkHits();
  
  if(keyPressed && (key== ESC)){
    exit();
  }
  
  textFont(f);
  fill(255, 0, 0);
  textAlign(CENTER);
  text("Left click to add balls. Right click to remove balls. Max:40  ESC to exit", 
      width/2, 700);
  fill(0, 250, 0);
  text("Current: " + count, width/2, 750);
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