/* ***********************************************************************
* Jiashu Long
* Paint By Dot
* Computer Science 10
* Apr 17th

* This program is my own work - J.L */

//Variables
int a=0;
int b=0;
int c=0;
int d=0;

void setup() {
  size((2000/2), (1300/2));
  background(255);
  smooth();
  noStroke();
}


void draw() {

  //Panel setup
  fill(240);
  rect (0, 0, 2000/2, 200/2);
  fill(255, 0, 0);
  ellipse(100/2, 100/2, 75/2, 75/2);//Red
  fill(0, 255, 0);
  ellipse(200/2, 100/2, 75/2, 75/2);//Green
  fill(0, 0, 255);
  ellipse(300/2, 100/2, 75/2, 75/2);//Blue
  fill(255, 255, 0);
  ellipse(400/2, 100/2, 75/2, 75/2);//Yellow
  fill(0);
  ellipse(500/2, 100/2, 75/2, 75/2);//Black
  fill(255);
  ellipse(700/2, 100/2, 75/2, 75/2);//White

  //Sizes
  fill(200);
  ellipse(1200/2, 100/2, 25/2, 25/2);//Small
  ellipse(1350/2, 100/2, 50/2, 50/2);//Medium
  ellipse(1500/2, 100/2, 75/2, 75/2);//Large
  ellipse(1650/2, 100/2, 100/2, 100/2);//X Large

  //Texts
  fill(0);
  textSize(60/2);
  text("Clear", 1800/2, 120/2);

  textSize(25);
  text("Colors", 260/2, 175/2);
  text("Eraser", 660/2, 175/2);
  text("Sizes", 1400/2, 175/2);

  //Selection: Colors
  if ((mouseX > (62.5/2)) && (mouseX < (137.5/2)) && (mouseY > (62.5/2)) && (mouseY < (137.5/2))&&(mousePressed==true)) {
    a=255;
    b=0;
    c=0;
  }
  if ((mouseX > (162.5/2)) && (mouseX < (237.5/2)) && (mouseY > (62.5/2)) && (mouseY < (137.5/2))&&(mousePressed==true)) {
    a=0;
    b=255;
    c=0;
  }
  if ((mouseX > (262.5/2)) && (mouseX < (337.5/2)) && (mouseY > (62.5/2)) && (mouseY < (137.5/2))&&(mousePressed==true)) {
    a=0;
    b=0;
    c=255;
  }
  if ((mouseX > 362.5/2) && (mouseX < 437.5/2) && (mouseY > 62.5/2) && (mouseY < 137.5/2)&&(mousePressed==true)) {
    a=255;
    b=255;
    c=0;
  }
  if ((mouseX > 462.5/2) && (mouseX < 537.5/2) && (mouseY > 62.5/2) && (mouseY < 137.5/2)&&(mousePressed==true)) {
    a=0;
    b=0;
    c=0;
  }
  if ((mouseX > 662.5/2) && (mouseX < 737.5/2) && (mouseY > 62.5/2) && (mouseY < 137.5/2)&&(mousePressed==true)) {
    a=255;
    b=255;
    c=255;
  }

  //Selection: Sizes
  if ((mouseX > 1175/2) && (mouseX < 1225/2) && (mouseY > 75/2) && (mouseY < 125/2)&&(mousePressed==true)) {
    d=0;
  }
  if ((mouseX > 1300/2) && (mouseX < 1400/2) && (mouseY > 50/2) && (mouseY < 150/2)&&(mousePressed==true)) {
    d=25/2;
  }
  if ((mouseX > 1425/2) && (mouseX < 1575/2) && (mouseY > 25/2) && (mouseY < 175/2)&&(mousePressed==true)) {
    d=50/2;
  }
  if ((mouseX > 1550/2) && (mouseX < 1750/2) && (mouseY > 0/2) && (mouseY < 200/2)&&(mousePressed==true)) {
    d=75/2;
  }
  if ((mouseX > 1800/2) && (mouseX < 2000/2) && (mouseY > 50/2) && (mouseY < 150/2)&&(mousePressed==true)) {
    fill(255);
    rect(0, 200/2, 2000/2, 1100/2);
  }

  //Draw
  fill(a, b, c);
  if (mousePressed==true) {
    ellipse(mouseX, mouseY, 25+d, 25+d);
  }
}
