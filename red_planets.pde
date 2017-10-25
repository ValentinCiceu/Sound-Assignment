

//this will be the stars engulfed by the black hole. after venus is gon
class Stars {
  PVector[] pos; 
  PVector foward;
  float speed;
  float maxSpeed;
  float minSpeed;
  float shrink;
  int choose;
  PVector blackHole;
  float spawnRate;
  float shrinkRate;
  color red;
  color blue;
  color yellow;
  color grey;
  int planetColor;

  Stars() { //constructer
    pos=new PVector[4];
    foward=new PVector();
    blackHole=new PVector(width/2, height/2);
    choose=(int)random(0, 4);
    spawnRate=1;
    shrink=25;
    shrinkRate=0.0005;
    minSpeed=random(0.25, 0.5);
    maxSpeed=random(1, 2);
    pos[0]=new PVector(random(width), -25); //top   
    pos[1]=new PVector(random(width), height+25);//bottom
    pos[2]=new PVector(-25, random(height));//left
    pos[3]=new PVector(width+25, random(height)); //right
    red=color(255, 0, 0);
    blue=color(0, 255, 255);
    grey=color(52, 73, 94);
    yellow=color(243, 129, 8);
    for (int i=0; i<4; i++) {
      int dice=(int)random(0, 4); 
      //int planetColor;
      if (dice==0) {
        planetColor=red;
      }
      if (dice==1) {
        planetColor=blue;
      }
      if (dice==2) {
        planetColor=yellow;
      }
      if (dice==3) {
        planetColor=grey;
      }
    }
  }


  void update() {
    //for(int i=0; i<5; i++){

    spawnRate+=1.5;
    shrink=lerp(shrink, 0, shrinkRate);//shrinking as it gets close to the middle

    foward=PVector.sub(blackHole, pos[choose]);
    foward.normalize();
    if(blackRadius<240){
    pos[choose].add(PVector.mult(foward, minSpeed));
    }
     if(blackRadius>240){
       foward.mult(4);
       pos[choose].add(PVector.mult(foward, minSpeed));
     }

    if (dist(blackHole.x, blackHole.y, pos[choose].x, pos[choose].y)<10) {
      stars.remove(this);
      stars.add(new Stars());
      //} //neseted and uneseted if statement gives an interesting result.
      if (spawnRate>100 && stars.size()<300) { //160
        stars.add(new Stars());
        spawnRate=0;
      }
      if (stars.size()>300) { //160
        //stars.clear();
        //stars.add(new Stars());
        stars.remove(this);
      }
    }
    //shrink control
    if (dist(blackHole.x, blackHole.y, pos[choose].x, pos[choose].y)<100) {
      shrinkRate=0.015;
      minSpeed=maxSpeed;
    }
   //if(blackRadius> 240 465
   if(blackRadius>240 && blackRadius<465){
    shrinkRate=0.005; 
   // maxSpeed=random(3,4);
   }
   if(blackRadius>465){
     //maxSpeed=random(5,6);
    shrinkRate=0.015; 
   }
   
  }


  void render() {
    //fill(r, g, b);
    //stroke(255,0,0);
    //fill(grey);
    fill(planetColor);
    ellipse(pos[choose].x, pos[choose].y, shrink, shrink);
  }
}
//use lerp function