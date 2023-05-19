/*
 As you move your mouse horizontally, robot will follow it smoothly. 
 Clicking the mouse will shrink the robot.
 Press 'N' to make the sunset and Night time.
 Pressing any key will bring back the day.
 When key 'B' is pressed robot's crazy freind will appear, but remember he will only appear during the day.
 */
float x = 60; // X-coordinate
float y = 720; // Y-coordinate
int radius = 45; // Head Radius
int bodyHeight = 160; // Body Height
int neckHeight = 70; // Neck Height
float easing = 0.02;
int time = millis();
int time1 = millis();

void setup() {
  size(800, 800);
  smooth();
  strokeWeight(2);
  ellipseMode(RADIUS);
}

void draw() {
  //makes robot short
  int targetX = mouseX;
  x += (targetX - x) * easing;
  if (mousePressed) {
    neckHeight = 16;
    bodyHeight = 90;
  } else {
    neckHeight = 70;
    bodyHeight = 160;
  }
  //Night time background
  if ((key == 'n') || (key == 'N')) {
    fill(0);
    rect(0, 0, 800, 800);
  }
  //Daytime background
  else {
    background(135, 206, 235);
    fill(11, 102, 35);
    rect(0, 720, 800, 280);
  }
  float ny = y - bodyHeight - neckHeight - radius;
  // Neck
  stroke(102);
  line(x+12, y-bodyHeight, x+12, ny);
  // Antennae
  line(x+12, ny, x-18, ny-43);
  line(x+12, ny, x+42, ny-99);
  line(x+12, ny, x+78, ny+15);
  // Body
  noStroke();
  fill(102);
  ellipse(x, y-33, 33, 33);
  fill(0);
  rect(x-45, y-bodyHeight, 90, bodyHeight-33);
  // Head
  fill(0);
  ellipse(x+12, ny, radius, radius);
  fill(255);
  ellipse(x+24, ny-6, 14, 14);
  fill(0);
  ellipse(x+24, ny-6, 3, 3);
  //Robot Best Friend
  if ((key == 'b') || (key == 'B')) {
    // Neck
    stroke(250); // Set stroke to gray
    line(266, 557, 266, 162); // Left
    line(276, 557, 276, 162); // Middle
    line(286, 557, 286, 162); // Right
    // Antennae
    line(276, 155, 146, 112); // Small
    line(276, 155, 506, 56); // Tall
    line(276, 155, 542, 170); // Medium
    // Body
    noStroke(); // Disable stroke
    fill(102); // Set fill to gray
    ellipse(214, 677, 43, 43); // Antigravity orb
    ellipse(314, 677, 43, 43); // Antigravity orb
    stroke(250);
    line(181, 677, 246, 677);
    line(213, 644, 213, 709);
    line(192, 655, 234, 698);
    line(234, 655, 192, 698);
    line(281, 677, 346, 677);
    line(313, 644, 313, 709);
    line(292, 655, 334, 698);
    line(334, 655, 292, 698);
    noStroke();
    fill(0); // Set fill to black
    rect(219, 557, 90, 120); // Main body 
    fill(250); // Set fill to gray
    //Flashing stripe
    int passedMillis = millis() - time; // calculates passed milliseconds
    if (passedMillis >= 300) {
      time = millis();
      fill(255, 0, 0);  // if more than 300 milliseconds passed set fill color to red
    }
    rect(219, 574, 90, 6); // Gray stripe
    // Head
    fill(0); // Set fill to black
    ellipse(276, 155, 45, 45); // Head
    fill(255); // Set fill to white
    //Flahing eye
    int passedMillis1 = millis() - time1; // calculates passed milliseconds
    if (passedMillis1 >= 300) {
      time1 = millis();
      fill(255, 0, 0);  // if more than 300 milliseconds passed set fill color to red
    }
    ellipse(288, 150, 14, 14); // Large eye
    fill(0); // Set fill to black
    ellipse(288, 150, 3, 3); // Pupil
    fill(153); // Set fill to light gray
    ellipse(263, 148, 5, 5); // Small eye 1
    ellipse(296, 130, 4, 4); // Small eye 2
    ellipse(305, 162, 3, 3); // Small eye 3
  }
}
