

class Objects {

  PVector pos;
  PVector fwd;
  PVector tar;
  float objectSpeed, speedMax=10, speedMin=5; 

  Objects(float x, float y) {
    pos = new PVector(x, y);
    objectSpeed = random(speedMin, speedMax);
  }
  Objects(float x, float y, float speed) {
    pos = new PVector(x, y);
    speed = objectSpeed;
  }


  void update() {
  }
  void render() {
  }
}

class QurterNote extends Objects {

  float bobleSize = 1;

  QurterNote(float x, float y) {

    super(x, y);

    tar =new PVector(random(0, width), random(0, height));
    // println(tar);
    fwd = tar.sub(pos);
    fwd.normalize();
    fwd.mult(objectSpeed);
  }

  void render() {

    ellipse(pos.x, pos.y, bobleSize, bobleSize);
    line((pos.x+ bobleSize/2), pos.y, pos.x+ bobleSize/2, pos.y -(bobleSize*2.5));


    if (bobleSize < 20) {

      bobleSize+= 0.5f;
    }
  }
  void update() {

    pos.add(fwd);

    if (pos.x < 0
      || pos.x > width
      || pos.y > boxY + (boxSize/3)/2
      || pos.y < boxY - (boxSize/3)/2) {

      for (int i = 0; i < 4; i++) { 
        //Objects c;

        //c = new QuaverNote(pos.x, pos.y);
        objects.add(new QuaverNote(this.pos.x, this.pos.y));
        objects.remove(this);
      }
      //boxSize --;
      speedMax++;
      speedMin ++;
    }
  }
}
class QuaverNote extends Objects {

  float bobleSize = 10;

  QuaverNote(float x, float y) {

    super(x, y);
    tar =new PVector(random(0, width), random(0, height));
    //println(tar);
    fwd = tar.sub(pos);
    fwd.normalize();
    fwd.mult(objectSpeed);
  }

  void render() {

    ellipse(pos.x, pos.y, bobleSize, bobleSize);
    line((pos.x+ bobleSize/2), pos.y, pos.x+ bobleSize/2, pos.y -(bobleSize*2.5));
    line(pos.x+ bobleSize/2, pos.y -(bobleSize*2.5), pos.x + (bobleSize*2 + bobleSize/2), pos.y -(bobleSize*2));
    //line(pos.x+ bobleSize,pos.y -(bobleSize*2.5)+ bobleSize/2,pos.x+ bobleSize/2,pos.y -(bobleSize*2.5));
    line(pos.x + (bobleSize*2 + bobleSize/2), pos.y, pos.x + (bobleSize*2 + bobleSize/2), pos.y -(bobleSize*2));
    ellipse(pos.x + bobleSize*2, pos.y, bobleSize, bobleSize);
  }
  void update() {
    bobleSize-= 0.5f;

    pos.add(fwd);
    if (bobleSize <= 0) {
      objects.remove(this);
      gameObjects.remove(this);
    }
  }
}
class Speaker extends Objects {
  float speakerSize = 50, yMod= 65, caseSize = 150;
  boolean tump = false; 


  Speaker(float x, float y) {

    super(x, y);
  }


  void update() {


    if (frameCount % 15 ==0 ) {
      objects.add( new QurterNote(pos.x, pos.y));
      objects.add( new QurterNote(pos.x, pos.y + yMod));
      tump = !tump;
    }
    if (tump == false) {
      speakerSize = 60;
    } else {
      speakerSize = 50;
    }
  }
  void render() {
    strokeWeight(1);
    fill(255);
    rect(pos.x, pos.y + 30, caseSize* 0.40f, caseSize);
    fill(155);
    rect(pos.x, pos.y + 30, caseSize* 0.35f, caseSize * 0.95f);
    fill(255);
    ellipse(pos.x, pos.y, speakerSize, speakerSize);
    ellipse(pos.x, pos.y + yMod, speakerSize, speakerSize);
    fill(200);
    ellipse(pos.x, pos.y, speakerSize * 0.75f, speakerSize* 0.75f);
    ellipse(pos.x, pos.y+ yMod, speakerSize * 0.75f, speakerSize* 0.75f);
    stroke(0);
    fill(255);
    ellipse(pos.x, pos.y + yMod, speakerSize * 0.25f, speakerSize* 0.25f);
    ellipse(pos.x, pos.y, speakerSize * 0.25f, speakerSize* 0.25f);
    fill(255);
  }
}
class Bullet extends Objects {
  float BulletSpeed = 4, size = 15 ;

  Bullet(float x, float y) {

    super(x, y);
  }

  void update() {

    pos.y -= BulletSpeed;

    if (pos.y < - 50) {
      miss("Bullet");
      gameObjects.remove(this);
    } 
    for (int i =0; i < gameBadGuy.size(); i ++) {
      Objects c;
      c = gameBadGuy.get(i);

      float  dist = PVector.dist(pos, c.pos);
      if (dist < 25) {
        hit();
        for (int f = 0; f < 4; f++) { 
          //Objects c;

          //c = new QuaverNote(pos.x, pos.y);
          gameObjects.add(new QuaverNote(c.pos.x, c.pos.y));
        }
        gameBadGuy.remove(i);
        gameObjects.remove(this);
      }
    }
  }
  void render() {

    rect(pos.x, pos.y, size* 0.2f, size);
  }
}
class BadGuy extends Objects {


  float badWidth =  50, speed;


  BadGuy(float x, float y, float speed) {

    super(x, y);
    //badGuyspeed = badGuyspeed;
    this.speed = speed;
  }
int counter =0;
  void render() {
  if(frameCount % 10 ==0){
    counter++;
  }
    //fill(255);
   // rect(pos.x, pos.y, badWidth, badWidth);
    imageMode(CENTER);
    image(flap[2-counter], pos.x,pos.y);
    
    if(counter >= 1){
      counter =0;
    }
    
    //println(pos);
  }

  void update() {


    pos.y += speed;
    //println(speed);

    if (pos.y > 600) {
      for (int i = 0; i < 4; i++) { 
        //Objects c;

        //c = new QuaverNote(pos.x, pos.y);
        gameObjects.add(new QuaverNote(this.pos.x, this.pos.y));
      }
      miss("BadGuy");
      killLineB = true;
      gameBadGuy.remove(this);
    }


    if (pos.y > killLine) {
      for (int i = 0; i < 4; i++) { 
        //Objects c;

        //c = new QuaverNote(pos.x, pos.y);
        gameObjects.add(new QuaverNote(this.pos.x, this.pos.y));
      }
      gameBadGuy.remove(this);
    }
  }
}