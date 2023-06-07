/* ***********************************************************************
 * Austin Lu
 * Paint by dot
 * CompSci 10 (Block 4)
 * Oct 22
 
 * This program is my own work - A.L.  */
void setup() {
  size(1600, 800);
  smooth();
  background(0);
  ellipseMode(RADIUS);
}
int slideX=1500; // X value of the slider
int slideY=100; // Y value of slider
int slideR=20; // radius of the slider
int whiteR=10; // radius of white paint
int redR=10; // radius of red paint
int greenR=10; // radius of green paint
int blueR=10; // radius of blue paint
int yellowR=10; // radius of yellow paint
int purpleR=10; // radius of purple paint
int eraseL=20; // size of the eraser
int R=255; // R value of the pen
int G=255; // G value of the pen
int B=255; // B value of the pen
void slider() { // A dot size slider because I like hurting myself
  slideR=20;
  stroke(0);
  strokeWeight(70);
  rect(1500, 0, 30, 800); // Localized background reset
  stroke(140);
  strokeWeight(10);
  fill(255);
  line(1500, 100, 1500, 700);
  if (mousePressed && mouseX<1520 && mouseX>1480 && mouseY<=700 && mouseY >= 100) {
    slideR=25;
    slideY=mouseY;
  }else if(mouseX<1520 && mouseX>1480 && mouseY<=700 && mouseY >= 100){
    slideR=25;
  }
   ellipse(slideX, slideY, slideR, slideR);
}
void pen() {
 
  noStroke();
   if (mousePressed && mouseX<1560 && mouseX>1550 && mouseY<105 && mouseY >95) {
    whiteR=15;
    R=255;
    G=255;
    B=255;
  }else if(mouseX<1560 && mouseX>1550 && mouseY<105 && mouseY >95){
    whiteR=15;
  }
  if (mousePressed && mouseX<1560 && mouseX>1550 && mouseY<205 && mouseY >195) {
    redR=15;
    R=255;
    G=5;
    B=5;
  }else if(mouseX<1560 && mouseX>1550 && mouseY<205 && mouseY >195){
    redR=15;
  }
  if (mousePressed && mouseX<1560 && mouseX>1550 && mouseY<305 && mouseY >295) {
    greenR=15;
    R=5;
    G=255;
    B=5;
  }else if(mouseX<1560 && mouseX>1550 && mouseY<305 && mouseY >295){
    greenR=15;
  }
    if (mousePressed && mouseX<1560 && mouseX>1550 && mouseY<405 && mouseY >395) {
    blueR=15;
    R=5;
    G=5;
    B=255;
  }else if(mouseX<1560 && mouseX>1550 && mouseY<405 && mouseY >395){
    blueR=15;
  }
    if (mousePressed && mouseX<1560 && mouseX>1550 && mouseY<505 && mouseY >495) {
    yellowR=15;
    R=255;
    G=255;
    B=5;
  }else if(mouseX<1560 && mouseX>1550 && mouseY<505 && mouseY >495){
    yellowR=15;
  }
   if (mousePressed && mouseX<1560 && mouseX>1550 && mouseY<605 && mouseY >595) {
    purpleR=15;
    R=180;
    G=5;
    B=255;
  }else if(mouseX<1560 && mouseX>1550 && mouseY<605 && mouseY >595){
    purpleR=15;
  }
   if (mousePressed && mouseX<1565 && mouseX>1545 && mouseY<690 && mouseY >650) {
    eraseL=25;
    R=0;
    G=0;
    B=0;
  }else if(mouseX<1565 && mouseX>1545 && mouseY<690 && mouseY >650){
    eraseL=25;
  }
  fill(R,G,B,50);
  if(mousePressed){
  ellipse(mouseX, mouseY, slideY/20, slideY/20);
  }
}
void colorSelector(){
  stroke(0);
  strokeWeight(40);
  rect(1555,0,40,800);
  noStroke();
  fill(255,255,255);
  ellipse(1555,100,whiteR, whiteR);
  fill(255,5,5);
  ellipse(1555,200,redR, redR);
  fill(5,255,5);
  ellipse(1555,300,greenR, greenR);
  fill(5,5,255);
  ellipse(1555,400,blueR, blueR);
  fill(255,255,5);
  ellipse(1555,500,yellowR, yellowR);
  fill(180,5,255);
  ellipse(1555,600,purpleR, purpleR);
  fill(255,255,255);
  rect(1545,650,eraseL, eraseL);
  fill(150);
  rect(1545,650+eraseL,eraseL, eraseL);
  whiteR=10;
  redR=10;
  greenR=10;
  blueR=10;
  yellowR=10;
  purpleR=10;
  eraseL=20;
}

void draw() { // runs and contains all functions
  ellipse(mouseX, mouseY, 10, 10)
  pen();
  slider();
  colorSelector();
}
