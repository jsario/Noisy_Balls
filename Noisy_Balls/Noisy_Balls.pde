Sphere ball = new Sphere(200, 200, 200, 15, 150, 250, 150, 250, 150, 250);
void setup(){
  size(400,400,P3D);
}

void draw(){
  background(0);
  ball.update();
  ball.display();
  ball.checkBoundaryCollision();
}