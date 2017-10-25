
///my work//V
void blackHole() { //black hole works
  tint(255, 128); 
  fill(255);
  stroke(255);
  ellipse(middleX, middleY, blackRadius, blackRadius); //white
  fill(0);
  stroke(0);
  grow+=rate;
  ellipse(blackHole.x, blackHole.y, grow, grow); //the black hole.
  if (grow>blackRadius-2) {
    rate=-0.05;
  }
  if (grow<blackRadius-11) {
    rate=+0.05;
  }

  for (int i=0; i<13; i++) { //to rotate the circles in the black hole
    theta+=0.001;
    float x=cx+sin(theta+(i*0.5))*22;
    float y=cy-cos(theta+(i*0.5))*22;
    fill(0);
    ellipse(x, y, 5, 5);
  }


  // println(stars.size());
}

/////////////////////////////////////////////////////////////////////////////////
///The mother Brain of frequency\\\\\
//////
void frequency() {
  //float min=100;
  //float minimaverage=0;
  //float mid=height/2.0f;
  ai.setGain(-20); 
  float total=0;
  for (int i=0; i<ai.bufferSize()-1; i++) {
    //minimaverage+=Math.abs(in.left.get(i));
    total+=abs(ai.left.get(i));
  }
  float average=total/ai.bufferSize();
  radius=lerp(radius, average, 0.1f);
  //float target=min+minimaverage*mid;
  //radius=lerp(radius,target,0.0001f);
  //ellipse(radius,250,10,10);
  fft.window(FFT.HAMMING);
  fft.forward(ai.left);

  float maxEnergy=0;
  int maxBin=-1;
  for (int i=0; i<fft.specSize(); i++) { 
    float energy= fft.getBand(i);
    if (energy>maxEnergy) {
      maxEnergy=energy;
      maxBin=i;
    }
  }
  float freq=fft.indexToFreq(maxBin);
  float freq2=fft.indexToFreq(maxBin);

  textSize(40);
  //text("Frequency: " + freq, 10, 50);
  mGun = freq;
  if (average>0.03f) {
    println("Spell: " + spell2(freq2));
    println("Music");
  } else {
    println("silence");
  }
  if (stage==3) {
    if (average>0.01f) { //this shrinks the sun if you play the guitar
      sun-=0.25;
      musicRadius-=1; 
      goTo-=0.0001f;
      //println("goTo:"+goTo);
      //println("music");
    }
    if (goTo<=0) {
      goTo=0;
      sun=0;
    }
    if (musicRadius<0) {
      musicRadius=0; 
      sun=0;
    }
  } else {
    //println("silence");
  }
  ai.enableMonitoring();

  if (stage2Timer>1000 && blackRadius<width) { //shows text
    textSize(20);
    text("Increase the strength", 100, 100);
    text("of the BlackHole", 75, 120);
    text("with the power of music!", 100, 140);
  }
  if (stage2Timer>1000) { //as you play the guitar the blackhole increases in size
    if (average>0.01f) {
      grow+=0.5f;
      blackRadius+=0.5f;
    }
  }
  if (blackRadius>width) {
    stage=4;
  }
  if (average>0.01f) {
    xAngle+=speedAngle;
    zAngle+=speedZAngle;
    ////this is to control the lerp colurs for the visuals
    nRate+=rate1; 
    nRate3+=rate3; 
    nRate5+=rate5;
    nRate2+=rate2;
    nRate4+=rate4;
    specialRate+=rate5;
    if (nRate>1) {
      rate1-=0.001;
    } else if (nRate<0.01) {
      rate1+=0.001;
    }

    if (nRate2>1) {
      rate2-=0.005;
    } else if (nRate2<0.01) {
      rate2+=0.005;
    }

    if (nRate3>1) {
      rate3-=0.0025;
    } else if (nRate3<0.01) {
      rate3+=0.0025;
    }

    if (nRate4>1) {
      rate4-=0.0125;
    } else if (nRate4<0.01) {
      rate4+=0.0125;
    }

    if (nRate5>1) {
      rate5-=0.028;
    } else if (nRate5<0.01) {
      rate5+=0.028;
    }
    if (specialRate>1) {
      rate6-=0.001;
    } else if (specialRate<0.01) {
      rate6+=0.001;
    }
  }


  if (freq>=1184 && average>0.01f) {
    circleRadius=0;
    aeroRadius=0;
    triPoint=0;
    lg=0;
  }
  //if (average>0.1f) {  //play the b strong on 12 up to get effect!
  //  cTestR=random(255);
  //  cTestG=random(255);
  //  cTestB=random(255);
  //}
  //println(average);


  ///for the shooter level

  /*if (average>0.03f) {
   println("Spell: " + spell(freq));
   println("Music");
   } else {
   println("silence");
   }
   
   if (spell(freq)=="E" && average>0.3) { //make sure the guitar is on ryhtme and not on treble for this to work
   canPress = false; 
   gameObjects.add(new Bullet(areaOne[0].x, areaOne[0].y));
   
   restartE++;
   }
   if (spell(freq)=="A" && average>0.1) {
   canPress = false; 
   gameObjects.add(new Bullet(areaOne[1].x, areaOne[1].y));
   
   restartA++;
   }
   if (spell(freq)=="D" && average>0.1) {
   canPress = false; 
   gameObjects.add(new Bullet(areaOne[2].x, areaOne[2].y));
   
   restartD++;
   }
   if (spell(freq)=="G" && average>0.2) {
   canPress = false; 
   gameObjects.add(new Bullet(areaOne[3].x, areaOne[3].y));
   
   restartG++;
   }
   if (spell(freq)=="B" && average>0.1) {
   canPress = false; 
   gameObjects.add(new Bullet(areaOne[4].x, areaOne[4].y));
   
   restartB++;
   }
   if (spell(freq)=="e" && average>0.1) {
   canPress = false; 
   gameObjects.add(new Bullet(areaOne[5].x, areaOne[5].y));
   
   restartF++;  //it is actually e
   }
   
   if (spell(freq)=="gCheat" && average>0.1) {
   canPress = false; 
   gameObjects.add(new Bullet(areaOne[6].x, areaOne[6].y));
   
   restartG++;
   }*/

  if (canFire[0] ==true && spell2(freq) =="f1" && average>0.08 ||canFire[0] ==true && spell2(freq) =="f1h" && average>0.1  ) {
    canFire[0] = false;
    gameObjects.add(new Bullet(areaOne[0].x, areaOne[0].y));
  }
  if (canFire[1] ==true && spell2(freq) =="f2" && average>0.08||canFire[0] ==true && spell2(freq) =="f2h" && average>0.1 ) {
    canFire[1] = false;
    gameObjects.add(new Bullet(areaOne[1].x, areaOne[1].y));
  }
  if (canFire[2] ==true &&spell2(freq) =="f3" && average>0.08||canFire[0] ==true && spell2(freq) =="f3h" && average>0.1 ) {
    canFire[2] = false;
    gameObjects.add(new Bullet(areaOne[2].x, areaOne[2].y));
  }
  if (canFire[3] ==true && spell2(freq) =="f4" && average>0.1 ||canFire[0] ==true && spell2(freq) =="f4h" && average>0.1 ) {
    canFire[3] = false;
    gameObjects.add(new Bullet(areaOne[3].x, areaOne[3].y));
  }
  if (canFire[4] ==true && spell2(freq) =="f5" && average>0.01 ||canFire[0] ==true && spell2(freq) =="f5h" && average>0.01 ) {
    canFire[4] = false;
    gameObjects.add(new Bullet(areaOne[4].x, areaOne[4].y));
  }
  if (canFire[5] ==true && spell2(freq) =="f6" && average>0.05) {
    canFire[5] = false;
    gameObjects.add(new Bullet(areaOne[5].x, areaOne[5].y));
  }
  if (canFire[6] ==true &&spell2(freq) =="f7" && average>0.05) {
    canFire[6] = false;
    gameObjects.add(new Bullet(areaOne[6].x, areaOne[6].y));
  }

  //for the stage3 intro to visuals
  if (stage==2) {
    if (shrunkTimes==2) {
      transitionTimer+=transitionTimerSpeed;

      if (transitionTimer>2000) {
        if (spell(freq)=="E" && average>0.3) {
          stage=3;
          isSwitch=true;
        }
      }
    }


    //changing between last 3 visuals doesnt work
    //if (stage>4) {
    //  if (spell(freq)=="e15" ) {
    //    stage=5;
    //  }
    //  if (spell(freq)=="e16" ) {
    //    stage=6;
    //  }
    //  if (spell(freq)=="e17" ) {
    //    //stage=7; //michaels work
    //  }
    //}
    //if (stage>=5) {
    //  if (spell(freq)=="e15" ) {
    //    stage=4;
    //  }
    //}
    //if (stage==4) {
    //  if (spell(freq)=="e15" ) {
    //    stage=5;
    //  }
    //  if (spell(freq)=="e16" ) {
    //    stage=6;
    //  }
    //  if (spell(freq)=="e17" ) {
    //    //stage=7; //michaels work
    //  }
    //}
  }
  ////if (boxTimer>100) {//spawns cube when guitar is played.
  //if(average>0.01){
  //box.add(new Box(250, 250)); //b
  //box.add(new Box(250, 250));
  //box.add(new Box(250, 250));
  //box.add(new Box(250, 250));
  //box.add(new Box(750, 250));//b1
  //box.add(new Box(750, 250));
  //box.add(new Box(750, 250));
  //box.add(new Box(750, 250));
  //box.add(new Box(750, 500));//b3
  //box.add(new Box(750, 500));
  //box.add(new Box(750, 500));
  //box.add(new Box(750, 500));
  //box.add(new Box(250, 500));//b4
  //box.add(new Box(250, 500));
  //box.add(new Box(250, 500));
  //box.add(new Box(250, 500));
  //boxTimer=0;
  //}
}
/////////////////////////////////////////////////////////////////////////////////////

void solarSyetm() {
  //camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);//some intersting results with the camera.



  float midMusic=height/2.0f;
  float myMusicAverage=0;

  for (int i=1; i<myMusic.bufferSize(); i++) {
    myMusicAverage+=Math.abs(myMusic.left.get(i));
  }

  myMusicAverage/=myMusic.bufferSize();
  float minMusic=100;
  float musicTarget=minMusic+ myMusicAverage * midMusic;
  musicRadius=lerp(musicRadius, musicTarget, goTo); //0.1f
  myMusic.setGain(-10); //my musuic volume
  musicTimer+=musicTimerSpeed;
  if (musicTimer>=0 && musicTimer<=1.5) { //this will only play one at a time.
    myMusic.trigger();
  }

  if (musicTimer>=8788.5) {
    myMusic.stop(); //this stops the music
    musicTimer=0;
  }
  //musicRadius-=10; //this kinda works, it will shrink the sphere down but only gradually


  //println("musicRadius: " +musicRadius);  





  sx+=0.005;
  stest+=0.05;
  pushMatrix();
  translate(solarPos.x, solarPos.y);
  rotateX(sx);
  rotateY(sx);
  rotateZ(sx);
  noStroke();
  fill(255, 190, 2);
  sphere(musicRadius); //355 //the sun   //sun
  popMatrix();
}


//////////////////////////////////////////////////////////////////////////////////////////////////


void first() {  //stage 5         ///the planets

  frequency();
  //muting beatMusic, playing my music
  if (stage==3) {
    if (beatTimer>0) {
      beatMusic.rewind();
      beatTimer=0;
    }
    beatMusic.setGain(-100); //beat music volume
  }
  if (stage==3) {
    myMusicTimer+=myMusicTimerSpeed;

    if (myMusicTimer<0) {

      //myMusic.play();
    }
  }

  //float total2=0;  //doesnt work!
  //for(int i=0; i<myMusic.bufferSize(); i++){
  //  total2+=abs(myMusic.left.get(i));
  //}
  //float average3 = total2 /myMusic.bufferSize();
  //planetRadius=lerp(planetRadius,average3,0.1f);


  //stage1 the solar system
  if (venus<=10) {
    for (int i=0; i<stars.size(); i++) {//the other red planets
      Stars s=stars.get(i);
      s.update();
      s.render();
    }
    stage2Timer+=stage2TimerSpeed;
  }

  timer+=timerSpeed;
  if (sun<=0) {
    sun=0; //sun size stays at 0
  }

  blackHole();
  solarSyetm();
  //for inheritence stuff
  for (int i=0; i<planets.size(); i++) {
    Planets p=planets.get(i);
    p.update();
    p.render();
  }

  //text("stage2timer :" + stage2Timer, 250, 50);
  if (blackRadius>width) {
    stage=4;
  }
}


////////////////////////////////////////////////////////////////////////

void visual() { //fully done.
  frequency();
  ai.setGain(-20);
  //aeroMusicTimer+=aeroMusicTimerSpeed;
  aero.setGain(-10); //aero music volume
  mainxAngle+=mainSpeedAngle;
  myMusic.stop(); //this stops my music from playing.
  cymbales.play();
  cymbaleTimer+=cymbaleTimerSpeed;


  //this triggers the cymbales and introduces the aero music
  aeroTriggerMusic();
  //if (cymbaleTimer>100) {   

  //    aeroMusicTimer+=aeroMusicTimerSpeed;
  //  if (aeroMusicTimer>=0 && aeroMusicTimer<=1.5) {
  //    aero.trigger();
  //  }
  //}

  //this is the HUD
  textSize(20);
  text("Press the arrow Keys", -500, -300);
  text("To change Visual", -500, -250);

  color newColor=lerpColor(first, second, nRate);

  color newColor3=lerpColor(fifth, sixth, nRate3);
  color newColor4=lerpColor(seventh, eight, nRate4);
  color newColor5=lerpColor(ninth, tenth, nRate5);
  //for lerp color pyramids
  color newColorP3=lerpColor(fifth, sixth, nRate3);
  color newColorP5=lerpColor(second, fifth, nRate5);
  color specialColor=lerpColor(special1, special2, nRate5);
  color specialColor2=lerpColor(special4, special3, specialRate);

  float mid2 = height / 2.0f;

  float aeroMid=height/0.2f;

  float average2 = 0;

  float aeroAverage=0;

  //int count23 = 0;

  for (int i = 1; i < ai.bufferSize(); i ++) //in replaced with audioInput

  {

    line(i, mid2, i, mid2 + ai.left.get(i) * mid2);

    average2 += Math.abs(ai.left.get(i));
  }   


  for (int i = 1; i < aero.bufferSize(); i ++) //in replaced with audioInput

  {

    line(i, aeroMid, i, aeroMid + aero.left.get(i) * aeroMid);

    aeroAverage += Math.abs(aero.left.get(i));
  }

  average2/=ai.bufferSize();

  aeroAverage /= aero.bufferSize();  

  float min2 = 100;  
  float aeroMin=100;

  float target2 = min2+ average2*53; //*mid2;//*53;//* mid23;

  float aeroTarget=aeroMin+aeroAverage *53; 

  circleRadius = lerp(circleRadius, target2, 0.1f);   
  aeroRadius=lerp(aeroRadius, aeroTarget, 0.1f);

  if (aeroAverage>0.5f) {   
    cTestR=random(255);
    cTestG=random(255);
    cTestB=random(255);
  }

  //println("aeroAverage: " + aeroAverage);

  //zAngle+=speedZAngle;
  pushMatrix(); //this is the main sphere
  translate(triMidX, triMidY);
  rotateX(mainxAngle);
  rotateY(mainxAngle);
  rotateZ(mainxAngle);
  noFill();
  //stroke(255, 0, 0);
  stroke(cTestR, cTestG, cTestB);
  strokeWeight(0.5);
  //sphere(test);  //////////////////////////////  the main sphere 355
  //test=lerp(test, 356, 0.05);
  //println(test);
  sphere(aeroRadius*3.5); //first sphere
  //sphere(circleRadius*3.5);

  popMatrix();

  for (int i=0; i<5; i++) {  //was 5
    //the pyramid
    triPoint=lerp(triPoint, 201, 0.005);
    //float newTri=((triPoint-(i*65)));  //was triPoint/i;
    //float newTri=((circleRadius*2-(i*65)));
    float newTri=((aeroRadius*2-(i*65)));
    if (i==0) {
      rColor=255;
      gColor=255;
      bColor=255;
      rColor2=220;
      gColor2=2;
      bColor2=255;
      pyramidColor=newColorP3;
      sphereColor=newColor3;
    }
    if (i==1) {
      rColor=255;
      gColor=243;
      bColor=2;
      rColor2=13;
      gColor2=2;
      bColor2=255;
      pyramidColor=specialColor2;
      sphereColor=newColor4;
    }
    if (i==2) {
      rColor=132;
      gColor=255;
      bColor=2;
      rColor2=255;
      gColor2=255;
      bColor2=255;
      pyramidColor=specialColor;  
      sphereColor=newColor;
    }
    if (i==3) {
      rColor=2;
      gColor=255;
      bColor=236;
      rColor2=2;
      gColor2=255;
      bColor2=297;
      pyramidColor=color(2, 255, 297);   
      sphereColor=color(2, 255, 236);
    }
    if (i==4) {
      rColor=255;
      gColor=255;
      bColor=255;
      rColor2=213;
      gColor2=255;
      bColor2=2;
      pyramidColor=newColorP5;
      sphereColor=newColor5;
      strokeWeight(1);
    }




    //stroke(0, 255, 255);  
    //stroke(rColor, gColor, bColor);  //for pyramid  good ones
    stroke(pyramidColor);
    pushMatrix();
    translate(triMidX, (triMidY)+(12*i), 0);  //was 12*i
    //stroke(255);
    rotateX(PI/2);
    //rotateX(x);
    //rotateY(y);
    //rotateZ(-PI/6);
    rotateZ(zAngle);
    beginShape();
    strokeWeight(1);
    ////////////////////////////////////////////////////////////////////////
    vertex(-newTri, -newTri, -newTri);
    vertex( newTri, -newTri, -newTri);
    vertex(   0, 0, newTri);

    vertex( newTri, -newTri, -newTri);
    vertex( newTri, newTri, -newTri);
    vertex(   0, 0, newTri);

    vertex( newTri, newTri, -newTri);
    vertex(-newTri, newTri, -newTri);
    vertex(   0, 0, newTri);

    vertex(-newTri, newTri, -newTri);
    vertex(-newTri, -newTri, -newTri);
    vertex(   0, 0, newTri);
    endShape();

    popMatrix();
    /////////////////////////////////////////////////////////////////

    pushMatrix();

    translate(spMidX, spMidY-(i*-20));
    if (i==0) { //this is purple
      translate(0, 50);
    }
    if (i==1) {
      translate(0, 20);
    }
    rotateX(-xAngle);
    rotateY(-xAngle);
    rotateZ(-xAngle);
    noFill();
    //stroke(255, 255, 0);
    //stroke(rColor2, gColor2, bColor2);//for sphere  good ones
    stroke(sphereColor);
    strokeWeight(0.5);
    if (i==0) {
      //strokeWeight(0.15);
    }
    if (i>3) {
      //strokeWeight((0.15-(i/3)));
      strokeWeight(0.005);
    }
    if (i==4) {
      //strokeWeight(0.15);
    }


    lg=lerp(lg, 201, 0.005);
    //sphere(lg-(65*i));//(spSize/i));   //35 works well   ///////////////////// lg=200
    //sphere(circleRadius*2-(65*i));
    sphere(aeroRadius*2-(65*i));
    popMatrix();
    //println(lg-(65*i));
  }

  //println(frameRate);
}

void cubes() {
  //background(0);
  //println(box.size());
  frequency();
  boxTimer+=boxTimerSpeed;


  float aeroMid=height/0.2f;
  float aeroAverage=0;
  for (int i = 1; i < aero.bufferSize(); i ++) //in replaced with audioInput

  {

    line(i, aeroMid, i, aeroMid + aero.left.get(i) * aeroMid);

    aeroAverage += Math.abs(aero.left.get(i));
  }

  aeroAverage /= aero.bufferSize(); 

  float aeroMin=100;

  float aeroTarget=aeroMin+aeroAverage *53; 

  aeroRadius=lerp(aeroRadius, aeroTarget, 1f);

  //this triggers th aero music
  // aeroMusicTimer+=aeroMusicTimerSpeed;  

  aero.setGain(-10); 
  cubeSize=aeroRadius/4;
  //if (aeroMusicTimer>=0 && aeroMusicTimer<=1.5) {
  //  aero.trigger();
  //}
  aeroTriggerMusic();

  if (aeroAverage>0.5) {
    cubeColorR=random(255);
    cubeColorG=random(255);
    cubeColorB=random(255);
  }


  for (int i=0; i<box.size(); i++) {
    Box b=box.get(i);
    b.update();
    b.show();
  }

  if (boxTimer>100) {//adding a new box every 1 second  //might change this to the guitar
    //cubeColorR=random(255);
    //cubeColorG=random(255);
    //cubeColorB=random(255);
    box.add(new Box(250, 250)); //b
    box.add(new Box(250, 250));
    box.add(new Box(250, 250));
    box.add(new Box(250, 250));
    box.add(new Box(750, 250));//b1
    box.add(new Box(750, 250));
    box.add(new Box(750, 250));
    box.add(new Box(750, 250));
    box.add(new Box(750, 500));//b3
    box.add(new Box(750, 500));
    box.add(new Box(750, 500));
    box.add(new Box(750, 500));
    box.add(new Box(250, 500));//b4
    box.add(new Box(250, 500));
    box.add(new Box(250, 500));
    box.add(new Box(250, 500));
    boxTimer=0;
  }
  //println("frameRate: " + frameRate);
  //println("aeroAverage: " + aeroAverage);
}



void terrain() { //the terrain generator
  //background(0);


  //for the guitar/##\\
  ai.setGain(-20); ///guitar volume //agai doesnt work 
  float total=0;
  for (int i=0; i<ai.bufferSize()-1; i++) {
    //minimaverage+=Math.abs(in.left.get(i));
    total+=abs(ai.left.get(i));
  }
  ai.enableMonitoring();
  float average=total/ai.bufferSize();
  radius=lerp(radius, average, 0.01f);

  //for the beat music 
  float aeroMid=height/0.2f;
  float aeroAverage=0;
  for (int i = 1; i < aero.bufferSize(); i ++) //in replaced with audioInput

  {

    line(i, aeroMid, i, aeroMid + aero.left.get(i) * aeroMid);

    aeroAverage += Math.abs(aero.left.get(i));
  }

  aeroAverage /= aero.bufferSize(); 

  float aeroMin=100;

  float aeroTarget=aeroMin+aeroAverage *53; 

  aeroRadius=lerp(aeroRadius, aeroTarget, 0.00001f);

  //this triggers the aero music
  //aeroMusicTimer+=aeroMusicTimerSpeed;  

  aero.setGain(-10); 
  aeroTriggerMusic(); //this is the trigger for aero music
  //if (aeroMusicTimer>=0 && aeroMusicTimer<=1.5) {
  //  aero.trigger();
  //}



  //flying-=aeroRadius/50;
  flying-=radius;
  float yoff=flying; //this is the y offset, in order to pinpoint evvery/most pixels on the y axis
  for (int y=0; y< rows; y++) {
    float xoff=0;//this is the x offset,
    for (int x=0; x<cols; x++) {
      terrain[x][y]=map(noise(xoff, yoff), 0, 1, -100, 100);
      //xoff+=aeroRadius/50; //0.02
      xoff+=radius;
    }
    //yoff+=aeroRadius/50;  //0.02
    yoff+=radius;
  }

  if (aeroAverage>0.5f) {   
    mapColorR=random(255);
    mapColorG=random(255);
    mapColorB=random(255);
  }
  strokeWeight(1);
  stroke(mapColorR, mapColorG, mapColorB);
  noFill();
  translate(width/2, height/2+50);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y=9; y< rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x=0; x<cols; x++) {
      vertex(x*scale, y*scale, terrain[x][y]);
      vertex(x*scale, (y+1)*scale, terrain[x][y]);
    }
    endShape();
  }
}


///look at Keys N Krates - Dum Dee Dum (JiKay Remix) 


void aeroTriggerMusic() {
  //this triggers the musi after the cymbales clashes.
  if (cymbaleTimer>100) {   

    aeroMusicTimer+=aeroMusicTimerSpeed;
    if (aeroMusicTimer>=0 && aeroMusicTimer<=1.5) {
      aero.trigger();
    }
    if (aeroMusicTimer>= 17226.5) { //this will reset the music back to 0
      aero.stop();
      aeroMusicTimer=0;
    }
  }
  println("aeroTimer" + aeroMusicTimer);
}









///this is for the cogs



void justChill() {



  colorChange =0;
  background(0);
  fill(255, 255, 255, 100);
  textSize(20);
  text("Space to EXIT", centerX, centerY + (centerY * 0.9f));
  if (keyPressed ==true) {  
    if (key == ' ') {
      stage=0;
    }
  }
  for (int i = 1; i < ai.bufferSize(); i ++)
  {
    colorChange += Math.abs(ai.left.get(i));
  }
  //colorChange /= mic.bufferSize();
  //println(colorChange);
  thetaTwo += colorChange/100;

  if (colorChange < 10) {

    while (endSplash.size() > 0) {

      endSplash.remove(0);
    }

    for ( int i =0; i < 100; i ++) {
      endSplash.add(new Cog(random(0, width), random(0, height), random(0, 50), random(0, 0.05f)));
    }
    for ( int i =0; i < 20; i ++) {
      endSplash.add(new Spinner(random(0, width), random(0, height), random(0, 20f)));
    }
  }


  for (int i =0; i < endSplash.size(); i ++) {
    Object c;
    c = endSplash.get(i);
    c.render();
    c.update();
  }

  cycleBig();
}
float x, y;
void cycleBig() {

  strokeWeight(10);
  //ellipse(centerX, centerY, 500,500);
  for ( int i =0; i < 20; i ++) {
    //miniCycle( i );
    miniCycleTwo(i);
    miniCycleThree(i);
  }
}

void miniCycle(float mod) {
  stroke(255, 0, 255);
  theta += 0.001f;
  x = centerX + ( sin( theta + mod) * rad);
  y = centerY + ( cos( theta + mod) * rad);

  ellipse(x, y, 250, 250);
}
float radTwoMod = 0.01f, thetaTwo;

void miniCycleTwo(float mod) {

  stroke(255, 255 - colorChange*2, 0);
  //thetaTwo -= 0.01f;
  x = centerX + ( sin( thetaTwo + mod) * radTwo);
  y = centerY + ( cos( thetaTwo + mod) * radTwo);
  radTwo += radTwoMod;

  if (radTwo < 50) {

    radTwoMod = 0.01f;
  }
  if (radTwo > 100) {

    radTwoMod = -0.01f;
  }


  ellipse(x, y, 75, 75);
}
float radThreeMod = 0.02f, thetaSpeedMod = 0.01f;
void miniCycleThree(float mod) {

  stroke(255, 200, colorChange, 150);
  //thetaTwo -= 0.01f;
  x = centerX + ( sin( thetaTwo/2 + mod) * radTwo);
  y = centerY + ( cos( thetaTwo/2 + mod) * radTwo);
  radTwo += radTwoMod;

  if (radTwo < 50) {

    radThreeMod = thetaSpeedMod ;
  }
  if (radTwo > 200) {

    radThreeMod = thetaSpeedMod;
  }


  ellipse(x, y, 200, 200);
}