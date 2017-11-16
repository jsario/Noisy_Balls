Sphere[] balls = new Sphere[10];

int[] box = {150, 475, 150, 500, 150, 300};
float x;
float y;
float z;
float size;
void setup(){
  size(600, 600, P3D);
  for(int i = 0; i < balls.length; i++){
    x = random(0, 600);
    y = random(0, 600);
    z = random(0, 600);
    size = random(1, 30);
    balls[i] = new Sphere(x, y, z, size, box, i);
  }
}

void draw(){
  background(0);
  for(Sphere ball : balls){
    ball.update();
    ball.display();
    ball.checkBoundaryCollision();
    //ball.toString();
  }
}