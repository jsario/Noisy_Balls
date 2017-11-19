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
  int counter = 0;

  Sphere(float x, float y, float z, float r_, int[] box, int i) {
    position = new PVector(x, y, z);
    velocity = PVector.random3D();
    velocity.mult(2);
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
      lights();
      counter = 120;
    } else if (position.x < left-radius) {
      position.x = left-radius;
      velocity.x *= -1;
      counter = 120;
    } else if (position.y > bottom-radius) {
      position.y = bottom-radius;
      velocity.y *= -1;
      counter = 120;
    } else if (position.y < top-radius) {
      position.y = top-radius;
      velocity.y *= -1;
      counter = 120;
    } else if(position.z < front-radius){
      position.z = front-radius;
      velocity.z *= -1;
      counter = 120;
    } else if(position.z > back-radius){
      position.z = back-radius;
      velocity.z *= -1;
      counter = 120;
    }
  }

  void checkCollision(Sphere other) {

    // Get distances between the balls components
    PVector distanceVect = PVector.sub(other.position, position);

    // Calculate magnitude of the vector separating the balls
    float distanceVectMag = distanceVect.mag();

    // Minimum distance before they are touching
    float minDistance = radius + other.radius;

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      other.position.add(correctionVector);
      position.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      /* bTemp will hold rotated ball positions. You 
       just need to worry about bTemp[1] position*/
      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      /* this ball's position is relative to the other
       so you can use the vector between them (bVect) as the 
       reference point in the rotation expressions.
       bTemp[0].position.x and bTemp[0].position.y will initialize
       automatically to 0.0, which is what you want
       since b[1] will rotate around b[0] */
      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;
      bTemp[1].z  = cosine * distanceVect.z + sine * distanceVect.y;

      // rotate Temporary velocities
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[0].z  = cosine * velocity.z - sine * velocity.z;
      vTemp[1].x  = cosine * other.velocity.x + sine * other.velocity.y;
      vTemp[1].y  = cosine * other.velocity.y - sine * other.velocity.x;
      vTemp[1].z  = cosine * other.velocity.z - sine * other.velocity.z;

      /* Now that velocities are rotated, you can use 1D
       conservation of momentum equations to calculate 
       the final velocity along the x-axis. */
      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      // final rotated velocity for b[0]
      vFinal[0].x = ((m - other.m) * vTemp[0].x + 2 * other.m * vTemp[1].x) / (m + other.m);
      vFinal[0].y = vTemp[0].y;
      vFinal[0].z = vTemp[0].z;

      // final rotated velocity for b[0]
      vFinal[1].x = ((other.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + other.m);
      vFinal[1].y = vTemp[1].y;
      vFinal[1].z = vTemp[1].z;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;
   

      /* Rotate ball positions and velocities back
       Reverse signs in trig expressions to rotate 
       in the opposite direction */
      // rotate balls
      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[0].z = cosine * bTemp[0].z - sine * bTemp[0].y;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;
      bFinal[1].z = cosine * bTemp[1].z - sine * bTemp[1].y;

      // update balls to screen position
      other.position.x = position.x + bFinal[1].x;
      other.position.y = position.y + bFinal[1].y;
      other.position.z = position.z + bFinal[1].z;

      position.add(bFinal[0]);

      // update velocities
      velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      velocity.z = cosine * vFinal[0].z - sine * vFinal[0].y;
      other.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
      other.velocity.z = cosine * vFinal[1].z - sine * vFinal[1].z;
    }
  }

  void display() {
    noStroke();
    fill(R, G, B);
    if(counter > 0){
      lights();
      counter -= 1;
    }
    translate(position.x, position.y, position.z);
    sphere(radius);
    translate(-1*position.x, -1*position.y, -1*position.z);
  }
  
  String toString(){
    return ("I'm  ball "+num+ ": x= "+position.x+ ", y= "+position.y+ ", z= "+position.z);
  }
}