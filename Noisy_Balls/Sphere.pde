class Sphere {
  PVector position;
  PVector velocity;
  int back;
  int top;
  int bottom;
  int left;
  int right;
  int front;
  float radius, m;
  int num;
  float R, G, B;

  Sphere(float x, float y, float z, float r_, int[] box, int i) {
    position = new PVector(x, y, z);
    velocity = PVector.random3D();
    velocity.mult(3);
    radius = r_;
    m = radius*.1;
    top = box[0];
    bottom = box[1];
    left = box[2];
    right = box[3];
    front = box[4];
    back = box[5];
    num = i;
    R = random(0, 255);
    G = random(0, 255);
    B = random(0, 255);
  }

  void update() {
    position.add(velocity);
  }

  void checkBoundaryCollision() {
    if (position.x > right-radius) {
      position.x = right-radius;
      velocity.x *= -1;
    } else if (position.x < left-radius) {
      position.x = left-radius;
      velocity.x *= -1;
    } else if (position.y > bottom-radius) {
      position.y = bottom-radius;
      velocity.y *= -1;
    } else if (position.y < top-radius) {
      position.y = top-radius;
      velocity.y *= -1;
    } else if(position.z < front-radius){
      position.z = front-radius;
      velocity.z *= -1;
    } else if(position.z > back-radius){
      position.z = back-radius;
      velocity.z *= -1;
    }
  }
  
  void display() {
    noStroke();
    fill(R, G, B);
    lights();
    translate(position.x, position.y, position.z);
    sphere(radius);
    translate(-1 * position.x, -1 * position.y, -1 * position.z);
  }
  
  String toString(){
    return ("I'm  ball "+num+ ": x= "+position.x+ ", y= "+position.y+ ", z= "+position.z);
  }
}