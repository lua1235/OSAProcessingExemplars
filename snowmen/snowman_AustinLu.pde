/* ***********************************************************************
* Austin Lu
* Snowman
* CompSci 10 (Block 4)
* 9/24/2020

* This program is my own work - A.L. */
void setup() {
 size(800,480);
 smooth();
 background(0);
 ellipseMode(RADIUS);
}
int x=400; // X value that all others are based on
int y=300; // Y value that all others are based on
int vX=0; // X velocity of snowball
int vY=0; // Y velocity of snowball
int launchX=x; // X value from where snowballs are launched
int launchY=y-60; // Y value from where snowballs are launched
int ballDist=0; // distance of ball from the snowman
int ballSize=10; // base size of snowball
void snowfall(){ // an array that creates the illusion of snowfall/blizzard
noStroke();
fill(250);
  for(int i=1; i<=800; i+=5){
    for(int p=1; p<=480; p+=5){
			int temp =random(1) 
      ellipse(i,p,temp, temp);
    }
  }
}
void faceprint(int hX, int hY){ // Creates the face
 int eyeX=hX; //Eye's X
 int eyeY=hY-4; //Eye's Y
 int mouthX=hX-11; // Left corner of mouth
 int mouthY=hY+4; // Right corner of mouth
 int noseX=hX; // nose X
 int noseY=hY; // nose Y
 int hatX=hX-15; // Hat's X
 int hatY=hY-35; // Hat's Y
 fill(0);
 //Eye start
 eyeX=eyeX+(mouseX-eyeX)/70; // eyeX mouse tracking
 eyeY=eyeY+(mouseY-eyeY)/70; // eyeY mouse tracking
 ellipse(eyeX-10,eyeY,3,3);
 ellipse(eyeX+10,eyeY,3,3);
 //Eye end
 //Mouth start
 mouthX=mouthX+(mouseX-mouthX)/70; // mouthX mouse tracking
 mouthY=mouthY+(mouseY-mouthY)/70; // mouthY mouse tracking
 ellipse(mouthX,mouthY,3,3);
 ellipse(mouthX+7,mouthY+4,3,3);
 ellipse(mouthX+15,mouthY+4,3,3);
 ellipse(mouthX+22,mouthY,3,3);
 //Mouth end
 //Nose start
 fill(247,136,0);
 ellipse(noseX+(mouseX-noseX)/70,noseY+(mouseY-noseY)/70,4, 4);
 stroke(247,136,0);
 strokeWeight(7);
 line(noseX+(mouseX-noseX)/70,noseY+(mouseY-noseY)/70,noseX+(mouseX-noseX)/40,noseY+(mouseY-noseY)/40);
 strokeWeight(5);
 line(noseX+(mouseX-noseX)/70,noseY+(mouseY-noseY)/70,noseX+(mouseX-noseX)/30,noseY+(mouseY-noseY)/30);
 strokeWeight(4);
 line(noseX+(mouseX-noseX)/70,noseY+(mouseY-noseY)/70,noseX+(mouseX-noseX)/20,noseY+(mouseY-noseY)/20);
 noStroke();
 //Nose end
 //Hat start
 hatY=hatY+(mouseY-hatY)/70;
 fill(75);
 rect(hatX,hatY,30,20);
}
void snowman(int a, int b){ // The central function for the entire snowman
 int midX= a; // X value of central snowball
 int midY= b-30; // Y value of central snowball
 int topX= a; // X value of uppermost snowball
 int topY= b-60; // Y value of uppermost snowball
  fill(230);
  ellipse(a,b,30, 30); //base
  ellipse(midX,midY,25, 25); //torso
  ellipse(topX,topY,20, 20); //head
  faceprint(topX, topY); // sticks the face on
}
void keys(){ //detectors for movement
   if(key=='d'||key==RIGHT) {
    x+=2;
  }else if(key=='a'||key==LEFT) {
    x-=2;
  }else if((key=='w'||key==UP)&&y>=250) {
    y-=2;
  }else if((key=='s'||key==DOWN)&&y<=460) {
    y+=2;
  }
}
void ballisticPhysics(){ //Calculates behavior of snowball
  if(launchX<800 && launchX>0 && launchY<480 && launchY>0 && ballSize<100){
    if(launchX!=x || launchY!=y-60){
  ellipse(launchX,launchY,ballSize, ballSize);
    }
  ballSize+=ballDist; // 3D effect
  launchX+=vX;
  launchY+=vY;
  }else{ // resets the snowball
    vX=0;
    vY=0;
    ballSize=10;
    ballDist=0;
  }
}
void mousePressed(){ // sequence that triggers the ballisticPhysics() function.
  if(vX==0 && vY==0){
  vX=(mouseX-launchX)/10;
  vY=(mouseY-launchY)/10;
  ballDist=2;
  }
}
void draw(){ // System in which all functions are based in
  background(0);
  fill(240);
  rect(0,250,800,480);
  snowman(x,y);
  //snowfall();
    if(keyPressed) {
   keys();
  }
    if(vX==0 && vY==0) { //tracks the start of the snowball to the head
      launchX=x;
      launchY=y-60;
   }
	fill(200);
  ballisticPhysics();
}
