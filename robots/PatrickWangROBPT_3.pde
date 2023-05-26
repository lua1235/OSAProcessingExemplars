/* ***********************************************************************
 * Patrick Wang
 * Exercise 6 - Robot 3: Response
 * Computer Science 10
 * March 9, 2020
 
 * This program is my own work -PW (portion of code copied from my Robot 1: Draw assignment) */
float x;
float y = 180;
float easing = 0.1;
float b = 257;
float h = 0;

void setup() {
  size(1200, 411);
}

void draw() {
  print (b);
  float targetX = mouseX;
  x += (targetX - x) * easing;

  float p = x;
  translate (p - 270, 0); //

  smooth();
  strokeWeight(2);
  background(random (50));
  ellipseMode(RADIUS);
  // Body
  noStroke(); // Disable stroke

  fill(50); // Set fill to black
  rect(215 + random (5), b, 90, 120 + 2*h); // Main body
  fill(102); // Set fill to gray
  rect(215 + random (5), b + 50, 90, 6); // Gray stripe
  fill(70); // Set fill to gray
  ellipse(223, 377, 33, 33); // Antigravity orb
  ellipse(303, 377, 33, 33); // Antigravity orb
  rect (228, 344, 70, 66);
  fill (10);

  ellipse(223, 377, 23 + random (5), 23 + random (5)); // Antigravity orb
  ellipse(303, 377, 23 + random (5), 23 + random (5)); // Antigravity orb
  stroke (10);
  strokeWeight (7);
  line (223, 377, 223 + 18, 377 + 18);
  strokeWeight (4);
  line (223, 377, 223 - 20, 377 - 20);
  strokeWeight (7);
  line (223, 377, 223 + 18, 377 - 18);
  strokeWeight (4);
  line (223, 377, 223 - 20, 377 + 20);

  strokeWeight (4);
  line (223, 377, 223 + 25, 377);
  strokeWeight (4);
  line (223, 377, 223 - 26, 377);
  strokeWeight (4);
  line (223, 377, 223, 377 - 26);
  strokeWeight (4);
  line (223, 377, 223, 377 + 26);

  strokeWeight (7);
  line (303, 377, 303 + 18, 377 + 18);
  strokeWeight (4);
  line (303, 377, 303 - 20, 377 - 20);
  strokeWeight (7);
  line (303, 377, 303 + 18, 377 - 18);
  strokeWeight (4);
  line (303, 377, 303 - 20, 377 + 20);

  strokeWeight (4);
  line (303, 377, 303 + 25, 377);
  strokeWeight (4);
  line (303, 377, 303 - 26, 377);
  strokeWeight (4);
  line (303, 377, 303, 377 - 26);
  strokeWeight (4);
  line (303, 377, 303, 377 + 26);

  //neck
  stroke (50);
  strokeWeight(6);
  line(256, b, 256, y); // Left
  line(266, b, 266, y); // Middle
  line(276, b, 276, y); // Right
  // Antennae
  stroke(random (255), random (255), 255);
  strokeWeight(4);
  line(266, y, random (x + 100), random (y + 100)); // Small
  line(266, y, random (x + 100), random (y + 100)); // Tall
  line(266, y, random (x + 100), random (y + 100)); // Medium
  // Head
  fill(50); // Set fill to black
  ellipse(266, y, 45, 45); // Head
  fill(random (255), 0, 0); // Set fill to white
  ellipse(266 + 7 + random (5), y - random (5), 14, 14); // Large eye
  fill(0); // Set fill to black
  ellipse(266 + 7 + random (5), y - random (5), 3, 3); // Pupil
  fill(153); // Set fill to light gray
  ellipse(266 - 8 - random (5), y - 2 - random (5), 5, 5); // Small eye 1
  ellipse(266 + 15 + random (5), y - 25 - random (5), 4, 4); // Small eye 2
  ellipse(266 + 24 + random (5), y + 2 + random (5), 3, 3); // Small eye 3

  //controls - up and down to change neck, left and right to change body
  if (keyPressed && (key == CODED)) { 
    if (keyCode == UP && (y > -10)) { // neck becomes longer
      y -= 5;
    }  
    if (keyCode == DOWN && (y < 411)) { // neck becomes shorter
      y += 5;
    }
    if (keyCode == LEFT && (h < 200)) { //body size grows
      b -= 2;
      h += 2;
    }  
    if  (keyCode == RIGHT && (h > 0)) { //body size shrinks
      b += 2;
      h -= 2;
    }
  }
}
