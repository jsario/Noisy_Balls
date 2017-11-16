Sphere[] balls = new Sphere[2];
int[] box = {150, 300, 150, 300, 150, 300};
float x;
float y;
float z;
float size;
void setup(){
  size(600, 600, P3D);
  for(int i = 0; i < balls.length; i++){
    x = random(175,225);
    y = random(175, 225);
    z = random(175, 225);
    size = random(10, 15);
    balls[i] = new Sphere(x, y, z, size, box, i);
  }
}

void draw(){
  background(0);
  for(Sphere ball : balls){
    ball.update();
    ball.display();
    ball.checkBoundaryCollision();
    println(ball);
    
  }
}