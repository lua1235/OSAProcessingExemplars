float mousePosX;
float mousePosY;

int sizeBrush;

color currentColor;

boolean isRedClicked = false;
boolean isOrangeClicked = false;
boolean isGreenClicked = false;
boolean isYellowClicked = false;
boolean isBlackClicked = false;
boolean isEraserClicked = false;
boolean isClearClicked = false;

String sizeOfBrush;

void setup() {
  frameRate(144);
  size(1080, 720);
  background(255);

  currentColor = color(255, 0, 0);
  sizeBrush = 8;

  ellipseMode(RADIUS);
}

void draw() {
  sizeOfBrush = "Press arrow keys to change size of brush:" + sizeBrush;

  //fill and stroke
  noStroke();
  fill(currentColor);

  //mouse variables
  mousePosX = mouseX;
  mousePosY = mouseY;

  //DRAW
  if (mousePressed) {
    ellipse(mousePosX, mousePosY, sizeBrush, sizeBrush);
    return;
  }

  //borders
  fill(0);
  rect(0, 0, 175, 720);
  rect(0, 0, 1080, 150);
  rect(905, 0, 175, 720);
  rect(0, 620, 1080, 150);



  //taskbar
  fill(75);
  rect(20, 20, 1040, 100);

  //ColorRed Select
  if (isRedClicked == true) {
    fill(255, 0, 0, 170);
  } else if (isRedClicked == false) {
    fill(255, 0, 0, 255);
  }

  rect(40, 45, 50, 50);

  //ColorOrange Select
  if (isOrangeClicked == true) {
    fill(255, 200, 60, 170);
  } else if (isOrangeClicked == false) {
    fill(255, 200, 60, 255);
  }

  rect(40 + 120, 45, 50, 50);

  //ColorGreen Select
  if (isGreenClicked == true) {
    fill(65, 255, 65, 170);
  } else if (isGreenClicked == false) {
    fill(65, 255, 65, 255);
  }

  rect(40 + 120 + 120, 45, 50, 50);


  //Eraser Select
  if (isEraserClicked == true) {
    fill(255, 255, 255, 170);
  } else if (isEraserClicked == false) {
    fill(255);
  }

  //eraser box
  rect(797, 40, 80, 50);
  
  //clear box
  fill(255);
  rect(897, 40, 70, 50);

  //Eraser text
  fill (255, 0, 0);
  textSize(24);
  text("Eraser", 800, 75);
  
  //clear text
  fill(255, 0, 0);
  textSize (24);
  text("Clear", 900, 75);


  //sizeTexxt
  fill(255, 0, 0);
  textSize(32);
  text(sizeOfBrush, 260, 700);
}

void mousePressed() {
  //40, 45, 50, 50 RED
  if (mousePosX < 90 && mousePosX > 40 && mousePosY < 95 && mousePosY > 45) {
    currentColor = color(255, 0, 0);
    isRedClicked = true;
  } else {
    isRedClicked = false;
  }
  //40 + 120, 45, 50, 50 ORANGE
  if (mousePosX < (180 + 50) && mousePosX > 180 && mousePosY < 95 && mousePosY > 45) {
    currentColor = color(#FFC83C);
    isOrangeClicked = true;
  } else {
    isOrangeClicked = false;
  }
  //40 + 120 + 120, 45, 50, 50 GREEN
  if (mousePosX < (120 + 120 + 40 + 50) && mousePosX > 180 + 120 && mousePosY < 95 && mousePosY > 45) {
    currentColor = color(65, 255, 65);
    isGreenClicked = true;
  } else {
    isGreenClicked = false;
  }
  //797, 40, 80, 50 ERASER
  if (mousePosX < (797 + 80) && mousePosX > 797 && mousePosY < 95 && mousePosY > 45) {
    currentColor = color(255);
    isEraserClicked = true;
  } else {
    isEraserClicked = false;
  }
  //897, 40, 70, 50 CLEar
  if (mousePosX < (897 + 70) && mousePosX > 897 && mousePosY < 95 && mousePosY > 45) {
    background(255);
  }
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT && sizeBrush < 25) {
      sizeBrush = sizeBrush + 1;
    } 
    if (keyCode == LEFT && sizeBrush > 1) {
      sizeBrush = sizeBrush - 1;
    }
  }
}
