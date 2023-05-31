
/* ***********************************************************************
 * Ishani Munasinghe
 * Assignment 2 - Pong
 * Computer Science 10 - Block 3
 * 01/05/20
 
 * This program is my own work - IM */
float xPosition;
float yPosition;
float paddleWidth;
float paddleHeight;
float dyLeftPaddleTop;
float dyLeftPaddleBot;
float dyRightPaddleTop;
float dyRightPaddleBot;
int level = 0;
//create new objects (paddles and ball)
LeftPaddle leftPaddle = new LeftPaddle(xPosition, yPosition, paddleWidth, paddleHeight);
RightPaddle rightPaddle = new RightPaddle(xPosition, yPosition, paddleWidth, paddleHeight);
Ball ball = new Ball(200, -20, 20, 20);
void setup() {
  size(1600*(7/10),900);
  background(230, 150, 250);
  noLoop(); // game doesn't start right away
}
void mousePressed() { // start/restart the game by pressing mouse to start the ball
  // mouse position determines placement of ball
  ball.x = mouseX;
  ball.y = mouseY;
  if (ball.ySpeed < 0.0) { // ball always moves downward (not upward) when ball placed
  ball.ySpeed = ball.ySpeed*-1;
  }
  loop(); // game starts
}
void keyPressed() {
  if (key == '8') { // press 8 to increase speed (level)
  ball.xSpeed = ball.xSpeed*1.25;
  ball.ySpeed = ball.ySpeed*1.25;
  level = level + 1; // level increases
  print(level);
  } else if (key == '2') { // press 8 to decrease speed (level)
  ball.xSpeed = ball.xSpeed*0.75;
  ball.ySpeed = ball.ySpeed*0.75;
  level = level - 1; //level decreases
  }
}
void draw() {
  ball.display();
  ball.going();
  noStroke();
  rightPaddle.display();
  rightPaddle.move();
  leftPaddle.display();
  leftPaddle.move();
  float dxl = (ball.x - ball.ballWidth/2) - (leftPaddle.xPosition + leftPaddle.paddleWidth); // distance between ball and left paddle
  float dxr = rightPaddle.xPosition - (ball.x + ball.ballWidth/2); // '' right paddle
  //check if ball is in boundary on left side
  boolean inLeftPaddle = false; // assume ball is out of boundaries
  dyLeftPaddleTop = (ball.y + ball.ballWidth/2) - (leftPaddle.yPosition); // distance between edge of the ball and the top edge of left paddle
  dyLeftPaddleBot = (leftPaddle.yPosition + leftPaddle.paddleHeight) - (ball.y - ball.ballWidth/2); // '' bottom edge of left paddle
  if ((dyLeftPaddleTop > 0) && (dyLeftPaddleBot > 0)) inLeftPaddle = true; // sets ball to bounce off left paddle
  //check if ball is in boundary on right side
  boolean inRightPaddle = false; // assume ball is out of boundaries
  dyRightPaddleTop = (ball.y + ball.ballWidth/2) - (rightPaddle.yPosition); // distance between edge of the ball and the top edge of right paddle
  dyRightPaddleBot = (rightPaddle.yPosition + rightPaddle.paddleHeight) - (ball.y - ball.ballWidth/2); // '' bottom edge of right paddle
  if ((dyRightPaddleTop > 0) && (dyRightPaddleBot > 0)) inRightPaddle = true; // sets ball to bounce off right paddle
  if (dxl <= 0 && dxl > -leftPaddle.paddleWidth && inLeftPaddle == true) {
  ball.xSpeed = ball.xSpeed*-1; // bounce off left paddle
  } else if (dxr <= 0 && dxr > -rightPaddle.paddleWidth && inRightPaddle == true) {
  ball.xSpeed = ball.xSpeed*-1; // bounce of right paddle
  }
  //instructions
  fill(0);
  rect(0, height*0.9, width, height*0.9); // black instruction box
  fill(255);
  textSize(18*(7/10));
  text("Welcome to Pong! Click the mouse in front of the paddle who is serving to start the game. To hit the ball, move the paddles as follows:", width*0.01, height*0.92);
  text("The red player presses 'w' to move up, 'a' to move left, 's' to move down', and 'd' to move right. The blue player uses the arrow keys.", width*0.01, height*0.94);
  text("If the ball touches the right end of the screen, the red player earns a point. If the ball touches the left end of the screen, the blue player earns a point.", width*0.01, height*0.96);
  textSize(22*(7/10));
  text("*NOTE: Paddle movement and level changing can only occur once the mouse is pressed and ball is in play.", width*0.01, height*0.99);
  //speed counter
  rect(width*0.8, height*0.9, width*0.8, height);
  fill(0);
  textSize(30*(7/10));
  text("Level: ______", width*0.85, height*0.98);
  text(level, width*0.91, height*0.97);
  textSize(15*(7/10));
  text("Press '8' or '2' to increase or decrease speed", width*0.81, height*0.93);
}

//BALL CLASS
class Ball {
  float xSpeed = 2;
  float ySpeed = 1;
  float x;
  float y;
  float ballHeight;
  float ballWidth;
  float tlStart;
  float tlLength;
  float tableHeight;
  float lightHeight;
  float dyTable;
  float dyLight;
  float dxLeftEdge;
  float dxRightEdge;
  int scoreRight = 0;
  int scoreLeft = 0;
  Ball(float xPosition, float yPosition, float ballHeight, float ballWidth) {
  x = xPosition;
  y = yPosition;
  this.ballHeight = ballHeight;
  this.ballWidth = ballWidth;
  }
  void display() {
  background(230, 150, 250); // purple background
  fill(148, 0, 211);
  ellipse(x, y, ballWidth, ballHeight); // set ball parameters
  //table and light variables
  tlStart = width*0.2; // left corner of the table and light
  tlLength = width*0.6; // table and light length (left + length = right corner)
  tableHeight = height*0.7;
  lightHeight = height * 0.3;
  //create light effect
  fill(255, 250, 205, 100); // transparent yellow light
  noStroke();
  quad(tlStart+10, lightHeight+29, tlLength+tlStart-10, lightHeight+29, width, height/2, 0, height/2);
  rect(0, height/2, width, tableHeight-height/2);
  rect(0, tableHeight, tlStart, height*0.9); // covers left portion of table
  rect(tlStart+tlLength, tableHeight, width, height*0.9); // covers right portion of table
  //brown table
  fill(181, 101, 29); // brown
  rect(tlStart, tableHeight, tlLength, 30, 50); // tabletop
  rect(tlStart + 200, tableHeight, 30, height); // left leg
  rect(tlStart + tlLength - 200 - 30, tableHeight, 30, height); // right leg
  //yellow light
  fill(240, 230, 140); // yellow
  rect(tlStart, lightHeight, tlLength, 30, 50); // light
  strokeWeight(5);
  stroke(240, 230, 140);
  line(width/2, 0, tlStart + 50, lightHeight); // left support
  line(width/2, 0, tlStart+ tlLength - 50, lightHeight); // right support
  stroke(255, 255, 255, 150); // middle white seperation line
  line(width/2, lightHeight + 30, width/2, tableHeight);
  }
  void going() {
  if (x <= ballWidth/2) {
    scoreRight = scoreRight + 1; //if ball touches left edge, right player earns point
    noLoop (); // game stops until mouse pressed
  }
  if (x >= width - ballWidth/2) {
    scoreLeft = scoreLeft + 1; //if ball touches right edge, left player earns point
    noLoop (); // game stops until mouse pressed
  }
  // scoreboards
  strokeWeight(10);
  stroke(255);
  textSize(64);
  // red score board
  fill(255, 0, 0);
  rect(width*0.2 - width*0.1, height*0.03, width*0.1, height*0.1);
  fill (255);
  text (scoreLeft, width*0.125, height*0.1); // left score
  // blue score board
  fill(0, 0, 255);
  rect(width*0.8, height*0.03, width*0.1, height*0.1);
  fill (255);
  text (scoreRight, width*0.825, height*0.1); // right score
  //set boundary variables
  dyTable = tableHeight - (ballHeight/2 + y); // distance between y position and table
  dyLight = (y - ballHeight/2) - (lightHeight + 30); // distance between y position and light
  dxLeftEdge = (x + ballWidth/2) - tlStart; // distance between x position and left edge of table and light
  dxRightEdge = (x - ballWidth/2) - (tlStart + tlLength); // distance between x position of right edge of table and light
  if ((dyTable <= 0 || dyLight <= 0) && (dxLeftEdge >= 0 && dxRightEdge <= 0)) {
    ySpeed = ySpeed*-1; // if ball touches table or light, bounce back
  }
  // ball going:
  x = x + xSpeed;
  y = y + ySpeed;
  }
}

//LEFTPADDLE CLASS
class LeftPaddle {
  float xPosition;
  float yPosition;
  float xInc;
  float yInc;
  float paddleWidth;
  float paddleHeight;
  LeftPaddle(float xPosition, float yPosition, float paddleWidth, float paddleHeight) {
  this.xPosition = xPosition;
  this.yPosition = yPosition;
  this.paddleWidth = paddleWidth;
  this.paddleHeight = paddleHeight;
  }
  void display() {
  fill(255, 0, 0); // red paddle
  xPosition = width*0.2 + xInc; // x changes when increments called (a or d pressed)
  yPosition = height*0.5 + yInc; // y changes when increments called (w or s pressed)
  paddleHeight = height/12;
  paddleWidth = paddleHeight/6;
  
  //restrict paddle from moving everywhere
  if (xPosition <= 0.0) {
    xPosition = 0.0; // paddle cannot move past left edge of scree
  }
  if (xPosition >= width/2-paddleWidth) {
    xPosition = width/2-paddleWidth; // cannot move past center line
  }
  if (yPosition >= ball.tableHeight-paddleHeight) {
    yPosition = ball.tableHeight-paddleHeight; // cannot move past table
  }
  if (yPosition <= ball.lightHeight + 30 ) {
    yPosition  = ball.lightHeight + 30; // cannot move past light
  }
  rect(xPosition, yPosition, paddleWidth, paddleHeight); // set paddle parameters
  }
  void move() {
  if (keyPressed) { // player controls
    if (key == 'w') {
      yInc = yInc - 10;
    } else if (key == 's') {
      yInc = yInc + 10;
    } else if (key == 'a') {
      xInc = xInc - 10;
    } else if (key == 'd') {
      xInc = xInc + 10;
    }
  }
  }
}
//RIGHTPADDLE CLASS
class RightPaddle {
  float xPosition;
  float yPosition;
  float xInc;
  float yInc;
  float paddleWidth;
  float paddleHeight;
  RightPaddle(float xPosition, float yPosition, float paddleWidth, float paddleHeight) {
  this.xPosition = xPosition;
  this.yPosition = yPosition;
  this.paddleWidth = paddleWidth;
  this.paddleHeight = paddleHeight;
  }
  void display() {
  fill(0, 0, 255); // blue paddle
  xPosition = width*0.8 + xInc; // x changes when increments called (left or right pressed)
  yPosition = height*0.5 + yInc; // y changes when increments called (up or down pressed)
  paddleHeight = height/12;
  paddleWidth = paddleHeight/6;
  //restrict paddle from moving everywhere
  if (xPosition >= width-paddleWidth) {
    xPosition = width-paddleWidth; // paddle cannot move past right edge
  }
  if (xPosition <= width/2) {
    xPosition = width/2; // cannot move past center line
  }
  if (yPosition >= ball.tableHeight-paddleHeight) {
    yPosition = ball.tableHeight-paddleHeight; // cannot move past table
  }
  if (yPosition <= ball.lightHeight + 30 ) {
    yPosition  = ball.lightHeight + 30; // cannot move past light
  }
  rect(xPosition, yPosition, paddleWidth, paddleHeight); // set paddle parameters
  }
  void move() { // player controls
  if (keyPressed && key == CODED) {
    if (keyCode == UP) {
      yInc = yInc - 10;
    } else if (keyCode == DOWN) {
      yInc = yInc + 10;
    } else if (keyCode == LEFT) {
      xInc = xInc - 10;
    } else if (keyCode == RIGHT) {
      xInc = xInc + 10;
    }
  }
  }
}
