/* ***********************************************************************
 * Patrick Wang
 * Assignment 2 - Paint By Dot
 * Computer Science 10
 * April 2, 2020
 * This program is my own work -PW */

//brush size
int rsbrush = 3; 
int rmbrush = 6;
int rlbrush = 12;
int rxlbrush = 18;
int rpaint = 6;

//brush color
float red = 0;
float green = 0;
float blue = 0;

void setup() {
  size(1500*(4/5), 900);
  smooth();
  ellipseMode(RADIUS);
  background (255);
  frameRate (200);
}

void draw() {
  print (mouseX, mouseY);

//clear button
 if (mousePressed && ((mouseX > 1300*(4/5)) && (mouseX < (1300*(4/5))+200) && (mouseY > 100) && (mouseY < 100+50))) { 
    fill(0);
    background (255);
  } else {
    fill(150);
  }
  rect(1300*(4/5), 100, 200*(4/5), 50);
  fill (0);
  textSize (25);
  text ("Clear Paint", 1333*(4/5), 135);
  
  //random color button
 if (mousePressed && ((mouseX > 300*(4/5)) && (mouseX < (300*(4/5))+300) && (mouseY > 100) && (mouseY < 100+40))) { 
    fill(0);
    red = random (255);
    green = random (255);
    blue = random (255);
  } else {
    fill(150);
  }
  rect(300*(4/5), 100, 300*(4/5), 40);
  fill (0);
  textSize (15);
  text ("Random Color", 400*(4/5), 124);

  //top menu
  noStroke ();
  fill (200);
  rect (0, 0, width, 100);
  fill (100);
  rect (1100*(4/5), 0, 10*(4/5), 100);

  //brush sizes
  float sd = dist(mouseX, mouseY, 1150*(4/5), 50); //small brush
  if (mousePressed && (sd < rsbrush)) {
    fill(0);
    rpaint = 3;
  } else {
    fill(255);
  }
  ellipse(1150*(4/5), 50, rsbrush, rsbrush);

  float md = dist(mouseX, mouseY, 1250*(4/5), 50); //medium brush
  if (mousePressed && (md < rmbrush)) {
    fill(0);
    rpaint = 6;
  } else {
    fill(255);
  }
  ellipse(1250*(4/5), 50, rmbrush, rmbrush);

  float ld = dist(mouseX, mouseY, 1350*(4/5), 50); //large brush
  if (mousePressed && (ld < rlbrush)) {
    fill(0);
    rpaint = 12;
  } else {
    fill(255);
  }
  ellipse(1350*(4/5), 50, rlbrush, rlbrush);

 float xld = dist(mouseX, mouseY, 1450*(4/5), 50); //large brush
  if (mousePressed && (xld < rxlbrush)) {
    fill(0);
    rpaint = 18;
  } else {
    fill(255);
  }
  ellipse(1450*(4/5), 50, rxlbrush, rxlbrush);

//brush color
  float dRed = dist(mouseX, mouseY, 100*(4/5), 50); //red brush
  if (mousePressed && (dRed < 30)) {
    fill(150, 0, 0);
    red = 255;
    green = 0;
    blue = 0;
  } else {
    fill(255, 0, 0);
  }
  ellipse(100*(4/5), 50, 30, 30);

  float dOrange = dist(mouseX, mouseY, 200*(4/5), 50); //orange brush
  if (mousePressed && (dOrange < 30)) {
    fill(#D87700);
    red = 255;
    green = 144;
    blue = 8;
  } else {
    fill(#FF9008);
  }
  ellipse(200*(4/5), 50, 30, 30);

  float dYellow = dist(mouseX, mouseY, 300*(4/5), 50); //yellow brush
  if (mousePressed && (dYellow < 30)) {
    fill(#D0D100);
    red = 254;
    green = 255;
    blue = 5;
  } else {
    fill(#FEFF05);
  }
  ellipse(300*(4/5), 50, 30, 30);

  float dGreen = dist(mouseX, mouseY, 400*(4/5), 50); //green brush
  if (mousePressed && (dGreen < 30)) {
    fill(0, 150, 0);
    red = 0; 
    green = 255;
    blue = 0;
  } else {
    fill(0, 255, 0);
  }
  ellipse(400*(4/5), 50, 30, 30);

  float dBlue = dist(mouseX, mouseY, 500*(4/5), 50); //blue brush
  if (mousePressed && (dBlue < 30)) {
    fill(0, 0, 150);
    red = 0;
    green = 0;
    blue = 255;
  } else {
    fill(0, 0, 255);
  }
  ellipse(500*(4/5), 50, 30, 30);

  float dPurple = dist(mouseX, mouseY, 600*(4/5), 50); //purple brush
  if (mousePressed && (dPurple < 30)) {
    fill(150, 0, 0);
    red = 225;
    green = 5;
    blue = 255;
  } else {
    fill(#E105FF);
  }
  ellipse(600*(4/5), 50, 30, 30);

  float dBrown = dist(mouseX, mouseY, 700*(4/5), 50); //brown brush
  if (mousePressed && (dBrown < 30)) {
    fill(#764D19);
    red = 152;
    green = 97;
    blue = 29;
  } else {
    fill(#98611D);
  }
  ellipse(700*(4/5), 50, 30, 30);

  float dBlack = dist(mouseX, mouseY, 800*(4/5), 50); //black brush
  if (mousePressed && (dBlack < 30)) {
    fill(100);
    red = 0;
    green = 0;
    blue = 0;
  } else {
    fill(0);
  }
  ellipse(800*(4/5), 50, 30, 30);

  float dEraser = dist(mouseX, mouseY, 950*(4/5), 50); //eraser
  if (mousePressed && (dEraser < 30)) {
    fill(70);
    red = 255;
    green = 255;
    blue = 255;
  } else {
    fill(255);
  }
  ellipse(950*(4/5), 50, 40, 40);
  textSize (15);
  fill (0);
  text ("Eraser", 928*(4/5), 53);

  //coloring
  if (mousePressed) {
    fill (red, green, blue);
    ellipse (mouseX, mouseY, rpaint, rpaint);
  }
}
