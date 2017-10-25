class Object {

  PVector pos;
  Object(float x, float y) {
    pos = new PVector(x, y);
  }

  void render() {
  }

  void update() {
  }
}

class Cog extends Object {


  float roty = 0.1f, size = 50, rads = 10, rotyChange;




  Cog(float x, float y, float size, float rotyChange) {

    super(x, y);
    this.size = size;
    this.rotyChange = rotyChange;
  }

  void render() {
    pushMatrix();
    noFill();
    stroke(255, 255, 255, colorChange/2);
    strokeWeight(size / 30);
    //ellipseMode(CORNER);
    ellipse(pos.x, pos.y, size, size);
    popMatrix();
  }

  void update() {
    roty += rotyChange;
    pos.x += sin(roty) * rads;
    pos.y += cos(roty) * rads;
  }
}
class Spinner extends Object {


  float roty = 0.1f, size = 50, mod, rads = 20, theta ;




  Spinner(float x, float y, float mod ) {

    super(x, y);
    this.mod = mod;
  }

  void render() {
    stroke(255, 200, 0, colorChange);
    ellipse(x, y, 75, 75);

    for ( int i =0; i < 6; i ++) {
      theta += 0.01f;
      rads += 0.001f;
      float ajustment = mod *i;
      x= pos.x + ( sin( theta + ajustment) * rads);
      y= pos.y + ( cos( theta + ajustment) * rads);
      ellipse(x, y, 75, 75);
    }
  }

  void update() {
  }
}