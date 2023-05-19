/* ***********************************************************************
 * Alice Yang
 * Robot 3: Response
 * CS10
 * April 6, 2020
 
 * This program is my own work - A.Y. */


//if you press the key "a" then you shnage the colour od the body to blue and if you press any other key, it changes to black
//if you press on mouse, body and neck height will change.
//the robot can move in all directions as well
float x = 60; // X-coordinate
float y = 440; // Y-coordinate
int radius = 45; // Head Radius
int bodyHeight = 80; // Body Height
int neckHeight = 20; // Neck Height
float easing = 0.05;
void setup() {
  size(360, 480);
  smooth();
  strokeWeight(2);


  ellipseMode(RADIUS);
}
void draw() {
  int targetX = mouseX;
  x += (targetX - x) * easing;
  int targetY = mouseY;
  y += (targetY - y) * easing;


  if (mousePressed) {
    neckHeight = 100;
    bodyHeight = 160;
  } else {
    neckHeight = 20;
    bodyHeight = 80;
  }
  float ny = y - bodyHeight - neckHeight - radius;
  background(198, 223, 255);
  // Neck
  stroke(33, 56, 85);
  line(x+12, y-bodyHeight, x+12, ny);
  // Antennae
  line(x+12, ny, x-18, ny-43);
  line(x+12, ny, x+42, ny-99);
  line(x+12, ny, x+78, ny+15);
  // Body
  noStroke();
  if (keyPressed) {
    if ((key == 'a') || (key == 'A')) 
      fill(23, 63, 255);
  } else {
    fill(255, 33, 241);
  }
  ellipse(x, y-33, 33, 33);
  fill(250, 73, 188);
  rect(x-45, y-bodyHeight, 90, bodyHeight-33);
  // Head
  fill(247, 85, 237);
  ellipse(x+12, ny, radius, radius);
  fill(255);
  ellipse(x+24, ny-6, 14, 14);
  fill(0);
  ellipse(x+24, ny-6, 3, 3);
}
