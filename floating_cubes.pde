
class Box {
  float x;
  float speed;
  float t;
  float change;
  PVector pos;
  PVector foward;
  PVector[] fall;
  int choose;
  float boxSpeed;
  float r, g, b;


  Box(float x, float y) {
    pos=new PVector(x, y);//(random(width), random(-500, height+500));//(250,250);//(random(width), random(-500, -10));
    foward= new PVector();
    speed=0.005;
    change=1;
    fall=new PVector[4];
    choose=(int)random(0, 4);
    boxSpeed=random(1, 5);
    //r=random(255); 
    //g=random(255); 
    //b=random(255);
    //cubeColorR=random(255);
    //cubeColorG=random(255);
    //cubeColorB=random(255);
  }



  void update() {


    x+=speed;

    t+=change;




    // PVector fall=new PVector(250, 250);
    for (int i=0; i<5; i++) { //interesting result when you comment out the for loop
      //dice
      //int choose=(int)random(0,4);

      //PVector[] fall=new PVector[4];
      fall[0]=new PVector(0, 0);
      fall[1]=new PVector(width, 0);
      fall[2]=new PVector(0, height);
      fall[3]=new PVector(width, height);

      foward=PVector.sub(fall[choose], pos);
      foward.normalize();
      //pos.add(PVector.mult(foward,boxSpeed));
      foward.mult(0.25);
      pos.add(foward);

      if (dist(fall[choose].x, fall[choose].y, pos.x, pos.y)<1) {
        box.remove(this);
      }
    }
    if (box.size()>100) {
      box.remove(this);
    }
    //cubeColorR=random(255);
    //cubeColorG=random(255);
    //cubeColorB=random(255);
  }


  void show() {
    pushMatrix();
    translate(pos.x, pos.y, 1);
    rotateX(x);
    rotateY(x);
    rotateZ(x);
    //noFill();

    fill(cubeColorR, cubeColorG, cubeColorB);
    //fill(r,g,b);
    box(cubeSize, cubeSize, cubeSize);
    //box(aeroRadius/4, aeroRadius/4, aeroRadius/4);
    //sphere(40);
    popMatrix();
  }
}
//now try this with expanding out. to the four corners.
//if you are able to do that then use to the guitar to spawn them as you play a note.