/* ***********************************************************************
* Austin Lu
* Robot 3
* CompSci 10 (Block 4)
* 9/24/2020

* This program is my own work - A.L. */
void setup(){
size(720, 480);
smooth();
strokeWeight(2);
background(204);
ellipseMode(RADIUS);
}
int headRadius=45; // Head radius (45)
int headX=255;// X value of head (276)
int headY=150; // Y value of head & antenna (190)
int eyeR=10; // Main eye radius (14)
int eyeX=headX+12; // X value of main eye
int eyeY=headY-5; // Y value of main eye
int neckHeight=headY+5; // Keeps neck level with head 
int sEye1X=headX-13; // X value of 1st small eye
int sEye1Y=headY;  // Y value of 1st small eye
int sEye2X=headX+20; // X value of 2nd small eye
int sEye2Y=headY-25; // Y value of 2nd small eye 
int sEye3X=headX+29; // X value of 3rd small eye
int sEye3Y=headY+7;  // Y value of 3rd small eye
int torsoX=headX-30; // X value of torso
int torsoY=257; // Y value of torso
int bodyHeight=torsoY-137; // Height of torso
int shoulderX=torsoX+115; // X value of shoulder
int shoulderY=torsoY-7; // Y value of shoulder
int elbowX=shoulderX+25; // X value of elbow
int elbowY=shoulderY+70; // Y value of elbow
int wristX=elbowX+30; // X value of wrist
int wristY=elbowY-30; // Y value of wrist
int pupilX=eyeX; // X value of main pupil
int pupilY=eyeY; // Y value of main pupil
int sPupil1X=sEye1X; // X value of 1st small pupil
int sPupil1Y=sEye1Y; // Y value of 1st small pupil
int sPupil2X=sEye2X; // X value of 2nd small pupil
int sPupil2Y=sEye2Y; // Y value of 2nd small pupil
int sPupil3X=sEye3X; // X value of 3rd small pupil
int sPupil3Y=sEye3Y; // Y value of 3rd small pupil
float wristEasing=0.2; // Wrist easing
int finger1JointX=wristX; // 1st finger joint X
int finger1JointY=wristY-15; // 1st finger joint Y
int finger2JointX=wristX+15; // 2nd finger joint X
int finger2JointY=wristY; // 2nd finger joint Y
int wristTargetX=0; // wrist's target X
int wristTargetY=0; // wrist's target Y
// Neck
void draw(){
  background(255);
  rect(0,407,720,480);
elbowX=shoulderX+(mouseX-shoulderX)/2; // Elbow X calculation
elbowY=shoulderY+(mouseY-shoulderY)/4; // Elbow Y calculation
finger1JointX=wristX+(mouseX-wristX)/2*3; // First finger joint X
finger1JointY=wristY+(mouseY-wristY)/20; // First finger joint Y
finger2JointX=wristX+(mouseX-wristX)/20; // Second finger joint X
finger2JointY=wristY+(mouseY-wristY)/2*3; // Second finger joint Y
wristTargetX=wristX+(mouseX-wristX)/2; //  displaces the X location of the wrist from the mouse
wristTargetY=wristY+(mouseY-wristY)/2; //displaces the Y location of the wrist from the mouse
wristX+=(wristTargetX-wristX)*wristEasing; // easing function for wristX
wristY+=(wristTargetY-wristY)*wristEasing; // easing function for wristY
neckHeight=headY+5; // Neck-to-head linking
// Eye-to-head linking
eyeX=headX+12; 
eyeY=headY-5; 
sEye1X=headX-13; 
sEye1Y=headY;  
sEye2X=headX+20;
sEye2Y=headY-25;
sEye3X=headX+29;
sEye3Y=headY+7;
// Torso linking
torsoX=headX-30; 
torsoY=257; 
bodyHeight=torsoY-137; 
shoulderX=torsoX+115; 
shoulderY=torsoY-7; 
// Link all pupils to mouse
pupilX=eyeX+(mouseX-eyeX)/55; // Main pupil X
pupilY=eyeY+(mouseY-eyeY)/55; // Main pupil Y
sPupil1X=sEye1X+(mouseX-sEye1X)/65; // 1st small pupil X
sPupil1Y=sEye1Y+(mouseY-sEye1Y)/65; // 1st small pupil Y
sPupil2X=sEye2X+(mouseX-sEye2X)/60; // 2nd small pupil X
sPupil2Y=sEye2Y+(mouseY-sEye2Y)/60; // 2nd small pupil Y
sPupil3X=sEye3X+(mouseX-sEye3X)/80; // 3rd small pupil X
sPupil3Y=sEye3Y+(mouseY-sEye3Y)/80; // 3rd small pupil Y
smooth();
stroke(102); // Set stroke to gray
strokeWeight(5);
line(headX-10, 257, headX-10, neckHeight); // Left
stroke(0);
strokeWeight(10);
line(headX, 257, headX, neckHeight); // Middle
stroke (102);
strokeWeight(5);
line(headX+10, 257, headX+10, neckHeight); // Right
// Antennae
strokeWeight(2); 
line(headX-30, headY, headX-30, headY-55); // Middle
line(headX, headY, headX, headY-99); // Longest
line(headX-15, headY, headX-15, headY-50);// Shortest
// Body
noStroke(); // Disable stroke
fill(102); // Set fill to gray
stroke(0);
strokeWeight(5);
ellipse(headX+10, 377, 33, 33); // Antigravity orb
noStroke();
fill(0); // Set fill to black
rect(torsoX, torsoY, 90,bodyHeight); // Main body
fill(102); // Set fill to gray
rect(torsoX, torsoY+17, 90, 6); // Gray stripe
rect(torsoX, torsoY+27, 90, 6); //
// Head
fill(0); // Set fill to black
circle(headX, headY, headRadius); // Head
fill(255); // Set fill to white
ellipse(eyeX, eyeY, eyeR, eyeR); // Large eye
fill(0); // Set fill to black
ellipse(pupilX, pupilY, 3, 3); // Pupil
fill(255); // Set fill to white
ellipse(sEye1X, sEye1Y, 10, 10); // Small eye 1
ellipse(sEye2X, sEye2Y, 8, 8); // Small eye 2
ellipse(sEye3X, sEye3Y, 6, 6); // Small eye 3
fill(0);
ellipse(sPupil1X, sPupil1Y, 2, 2); // Small pupil 1 
ellipse(sPupil2X, sPupil2Y, 2, 2); // Small pupil 2
ellipse(sPupil3X, sPupil3Y, 2, 2); // Small pupil 3
//Arm
strokeWeight(8);
stroke(100);
line(shoulderX, shoulderY, elbowX, elbowY);
//Shoulder
strokeWeight(4);
fill(0); // Set fill to black
circle(shoulderX, shoulderY, 10);
//Forearm
strokeWeight(8);
stroke(100);
line(elbowX, elbowY,wristX, wristY);
//Elbow
noStroke();
circle(elbowX, elbowY, 8);
strokeWeight(2);
circle(wristX, wristY, 4);
//Fingers
strokeWeight(6);
stroke(150);
line(wristX, wristY, finger1JointX, finger1JointY); //Fingers
strokeWeight(7);
line(finger1JointX, finger1JointY, mouseX-(mouseX-wristX)/15, mouseY-(mouseY-wristY)/3); //Fingers
strokeWeight(6);
line(wristX, wristY, finger2JointX, finger2JointY); //Fingers
strokeWeight(7);
line(finger2JointX, finger2JointY, mouseX-(mouseX-wristX)/3, mouseY-(mouseY-wristY)/15); //Fingers
//wrist
if(keyPressed) {
  if(key=='d'||key==RIGHT) {
    headX+=1;
  }else if(key=='a'||key==LEFT) {
    headX-=1;
  }else if(key=='w'||key==UP) {
    headY-=1;
  }
}
//NeckHeight modifier
if(mousePressed==true){
  headY-=1;
} else if(headY<150&&keyPressed==false){
  headY+=1;
}
//arrow keys control

}
