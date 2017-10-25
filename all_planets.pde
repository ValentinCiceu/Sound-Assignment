class Planets {
  PVector pos;
  PVector foward;
  float planetRotate;
  float rotateSpeed;
  float shrinkPlanets;

  Planets(float x, float y, float z) {
    pos=new PVector(x, y, z);
    foward=new PVector();
    planetRotate=0;
    //rotateSpeed=0;
    shrinkPlanets=0.005; 
  }

  void update() {
  }

  void render() {
  }
}