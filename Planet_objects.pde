class Earth extends Planets {


  Earth(float x, float y, float z) {
    super(x, y, z);
    planetRotate=0;
    rotateSpeed=0.005;
    //rotateSpeed=0.015;
  }

  void update() {
    planetRotate+=rotateSpeed;
    if (sun==0) {
      //planetRotate-=rotateSpeed;
      rotateSpeed=-0.005;
      if (planetRotate<=0) {
        planetRotate=0;
        //rotateSpeed=0;
        foward=PVector.sub(blackHole, pos); //works
        foward.normalize();
        foward.mult(3);
        pos.add(foward);
        if (dist(pos.x, pos.y, blackHole.x, blackHole.y)<200) {
          earth=lerp(earth, 0, shrinkPlanets);
        }
        if (dist(pos.x, pos.y, blackHole.x, blackHole.y)<20) {
          shrinkPlanets=0.025;
        }
      }
      if (earth<0) {
        earth=0;
      }
     
    }
    //println(planetRotate);
     //println("earth" +planetRotate);
  } //look at hsb colour space


  void render() {
    pushMatrix();
    rotateZ(planetRotate);
    rotateY(planetRotate);
    translate(pos.x, pos.y, -500);  //had no 50
    fill(0, 255, 255);
    sphere(earth);//255 //earth
    popMatrix();
  }
}

class Mars extends Planets {

  Mars(float x, float y, float z) {
    super(x, y, z);
    planetRotate=0;
    rotateSpeed=0.0055;
    //rotateSpeed=0.015;
  }


  void update() {
    planetRotate+=rotateSpeed;
    if (sun==0) {
      rotateSpeed=-0.0055;
      if (planetRotate<=0) {
        planetRotate=0;
        //rotateSpeed=0;
        foward=PVector.sub(blackHole, pos); //works
        foward.normalize();
        foward.mult(3);
        pos.add(foward);
        if (dist(pos.x, pos.y, blackHole.x, blackHole.y)<200) {
          mars=lerp(mars, 0, shrinkPlanets);
        }
        if (dist(pos.x, pos.y, blackHole.x, blackHole.y)<20) {
          shrinkPlanets=0.025;
        }
      }
    }
    if (mars<0) {
      mars=0;
    }
  }

  void render() {
    pushMatrix();
    rotateZ(planetRotate);
    translate(pos.x, pos.y, -100);
    rotateX(planetRotate);
    rotateY(planetRotate);
    rotateZ(planetRotate);
    fill(255, 0, 0);
    sphere(mars); //mars
    popMatrix();
  }
}

class Merc extends Planets {

  Merc(float x, float y, float z) {
    super(x, y, z);
    planetRotate=0;
    rotateSpeed=0.015;
  }

  void update() {
    planetRotate+=rotateSpeed;

    if (sun==0) {
      rotateSpeed=-0.015;
      if (planetRotate<=0) {
        planetRotate=0;
        //rotateSpeed=0;
        foward=PVector.sub(blackHole, pos); //works
        foward.normalize();
        foward.mult(3);
        pos.add(foward);
        if (dist(pos.x, pos.y, blackHole.x, blackHole.y)<200) {
          mercury=lerp(mercury, 0, shrinkPlanets);
        }
        if (dist(pos.x, pos.y, blackHole.x, blackHole.y)<20) {
          shrinkPlanets=0.025;
        }
      }
    }
    if (mercury<0) {
      mercury=0;
    }
    //println("mercury" +planetRotate);
  }

  void render() {
    pushMatrix();
    rotateY(planetRotate);
    translate(pos.x, pos.y);
    fill(52, 73, 94);
    sphere(mercury); //Mercury
    popMatrix();
  }
}

class Venus extends Planets {
  Venus(float x, float y, float z) {
    super(x, y, z); 
    planetRotate=0;
    rotateSpeed=0.025;
  }

  void update() {
    planetRotate+=rotateSpeed;

    if (sun==0) {
      rotateSpeed=-0.025;
      if (planetRotate<=0) {
        planetRotate=0;
        //rotateSpeed=0;
        foward=PVector.sub(blackHole, pos); //works
        foward.normalize();
        foward.mult(3);
        pos.add(foward);
        if (dist(pos.x, pos.y, blackHole.x, blackHole.y)<200) {
          venus=lerp(venus, 0, shrinkPlanets);
        }
        if (dist(pos.x, pos.y, blackHole.x, blackHole.y)<20) {
          shrinkPlanets=0.025;
        }
      }
    }
    if (venus<0) {
      venus=0;
    }
    //println("Venus" + planetRotate);
  }

  void render() {
    pushMatrix();
    rotateX(planetRotate);
    translate(pos.x, pos.y);
    fill(243, 129, 8);
    sphere(venus); //venus
    popMatrix();
  }
}