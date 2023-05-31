/* ***********************************************************************
 * Catherine Kim
 * Assignment 2- Pong
 * Block 2
 * Date Completed: 1/06/2019
 * This program is my own work - Digital Signature (CK) */
//initial ball coordinates
float ballX = 800;
float ballY = 400; 
float xspeed = 5;
float yspeed = 5; //initial ball speed
int score1 = 0;//starting score
int score2 = 0;
int c = 10; //initial background darkness 
//initial paddle's Y-coordinate
float y1 = 200; 
float y2 = 200;
float l = 400;//initial length of paddle 
//modes
boolean trainingMode = true;
boolean singlePlayer = false;
boolean multiPlayer = false;
boolean stop = false;

void setup() {
  size(1200, 800);
  stroke(255);
  strokeWeight(4);
}

void reset() {
  score1 = 0;
  score2 = 0; 
  l= 400;
  xspeed = 5;
  yspeed = 5;
  c = 10;
  ballX = width/2;
  ballY = height/2;
  y1 = 200; 
  y2 = 200;
  stop = false;
}

void keyPressed() {
  //different modes

  if (key == 't') {
    trainingMode = true;
    singlePlayer = false;
    multiPlayer = false;
    reset();
  } 
  if (key == '1') {
    singlePlayer = true;
    trainingMode = false;
    multiPlayer = false;
    reset();
  } 
  if (key == 'm') {
    singlePlayer = false;
    trainingMode = false;
    multiPlayer = true;
    reset();
  }
}
void draw() {
  textSize(48);
  // colorMode(HSB, 360, 100, 100);
  // color background = color();
  background(226, c, 95);  
  line(width/2, 0, width/2, height); //middle line
  //speed of ball
  ballX += xspeed;
  ballY += yspeed;

  // stop function
  if (stop) {
    xspeed = 0;
    yspeed = 0;
    ballX = width/2;
    ballY = height/2;
    background(0);
    textSize(48);
    text("YOU LOSE", 490, 400);
    text("Click mouse to restart", 370, 500);
    if (mousePressed) {
      reset();
    }
  }

  if (trainingMode) {
    singlePlayer = false;
    multiPlayer = false;
    fill(0, 0, 100);
    text("TRAINING MODE", 200, 55);
    text(score1, 710, 55);
    line(1000, 0, 1000, 800);
    //ball bounces off top and bottom
    if (ballY >= 800 || ballY <= 0) {
      yspeed *= -1;
    }
    if (ballX >= 1000) {
      xspeed *= -1;
      fill(60, 100, 100);
    } else {
      fill(0, 0, 100);
    }
    ellipse(ballX, ballY, 20, 20);

    //when ball bounces off paddle
    if (ballX <= 210 && ballX >= 200 && ballY >= y1 && ballY <= y1 + l) {
      xspeed *= -1;
      //turn yellow momentarily
      //score point and darken colour
      score1 ++;
      c += 2; 
      //make ball speed faster 
      xspeed += 2;
      yspeed += 2;
      //make the paddle length shorter 
      if (l > 20)
      {
        l -= 10;
      }
      fill(60, 100, 100);
    } else {
      fill(0, 0, 100);
    }
    ellipse(ballX, ballY, 20, 20);

    //moving of the paddle up and down 
    if (keyPressed && keyCode == UP && y1 > 0 && y1 <= 800-l) {
      y1 -= 5;
    }
    if (keyPressed && keyCode == DOWN && y1 >= 0 && y1 < 800-l) {
      y1 += 5;
    }
    fill(0, 0, 100);
    rect(200, y1, 10, l);

    if (ballX <= 0) {
      stop = true;
    }    
    if (score1 >= 40) {
      textSize(48);
      text("YOU WIN", 690, 400);
      text("Click mouse to continue", 530, 500);
      stop();
      if (mousePressed) {
        reset();
        singlePlayer = true;
      }
    }
  }  
  if (singlePlayer) {
    trainingMode = false;
    multiPlayer = false;
    fill(0, 0, 100);
    text("SINGLE-PLAYER MODE", 70, 55);
    text(score1, 730, 55);
    text(score2, 870, 55);
    //ball bounces off top and bottom
    if (ballY >= 800 || ballY <= 0) {
      yspeed *= -1;
    }
    //when ball bounces off paddle
    if (ballX <= 210 && ballX >= 200 && ballY >= y1 && ballY <= y1 + l) {
      xspeed *= -1;
      //turn yellow momentarily
      fill(60, 100, 100);
    } else {
      fill(0, 0, 100);
    }
    ellipse(ballX, ballY, 20, 20);  
    //moving of the paddle up and down 
    if (keyPressed && keyCode == UP && y1 > 0 && y1 <= 800-l) {
      y1 -= 5;
    }
    if (keyPressed && keyCode == DOWN && y1 >= 0 && y1 < 800-l) {
      y1 += 5;
    }
    fill(0, 0, 100);
    rect(200, y1, 10, l);
    if (ballY > 0) {
      y2 = ballY;
    } else {
      y2++;
    }
    if (ballY < 800-l) {
      y2 = ballY;
    } else {
      y2--;
    }
    rect(1000, y2, 10, l);
    if (ballX >= 1000 && ballY >= y2 && ballY <= y2 + l) {
      xspeed *= -1;
      fill(60, 100, 100);
    } else {
      fill(0, 0, 100);
    }
    ellipse(ballX, ballY, 20, 20);
    if (ballX <=0) {
      //score point and darken colour
      score2 ++;
      c += 2; 
      //make ball speed faster 
      xspeed += 2;
      yspeed += 2;
      ballX = width/2;
      ballY = height/2;
      //make the paddle length shorter 
      if (l > 20)
      {
        l -= 10;
      }
    }
    if (ballX >= width) {
      //score point and darken colour
      score1 ++;
      c += 2; 
      //make ball speed faster 
      xspeed += 2;
      yspeed += 2;
      ballX = width/2;
      ballY = height/2;
      //make the paddle length shorter 
      if (l > 20)
      {
        l -= 10;
      }
    }
    if (score2 >= 20) {
      stop = true;
    }    
    if (score1 >= 20) {
      stop = true;
    }
  } 
  if (multiPlayer) {
    trainingMode = false;
    singlePlayer = false;
    fill(0, 0, 100);
    textSize(36);
    text("MULTIPLAYER MODE", 80, 55);
    textSize(48);
    text(score1, (width/2) - 70, 55);
    text(score2, (width/2) + 70, 55);
    
    //ball bounces off top and bottom
    if (ballY >= 800 || ballY <= 0) {
      yspeed *= -1;
    }
    //when ball bounces off paddle
    if (ballX <= 210 && ballX >= 200 && ballY >= y1 && ballY <= y1 + l) {
      xspeed *= -1;
    fill(60, 100, 100);
    } else {
      fill(0, 0, 100);
    }
    ellipse(ballX, ballY, 20, 20);
    //moving of the 1st paddle up and down 
    if (keyPressed && keyCode == UP && y1 > 0 && y1 <= 800-l) {
      y1 -= 5;
    }
    if (keyPressed && keyCode == DOWN && y1 >= 0 && y1 < 800-l) {
      y1 += 5;
    }
    fill(0, 0, 100);
    rect(200, y1, 10, l);
    //moving of 2nd paddle
    if (keyPressed && key == 'w' && y2 > 0 && y2 <=800-l) {
      y2 -= 5;
    }
    if (keyPressed && key == 's' && y2 >= 0 && y2 < 800-l) {
      y2 += 5;
    }
    rect(1000, y2, 10, l);
  }
  if (multiPlayer && ballX >= 1000 && ballX <= 1100 && ballY >= y2 && ballY <= y2 + l) {
    xspeed *= -1;
  }
  if (ballX <=0) {
    //score point and darken colour
    score2 ++;
    c += 2; 
    //make ball speed faster 
    xspeed += 2;
    yspeed += 2;
    ballX = width/2;
    ballY = height/2;
    //make the paddle length shorter 
    if (l > 20)
    {
      l -= 10;
    }
  }
  if (multiPlayer && ballX >= 1200) {
    //score point and darken colour
    score1 ++;
    c += 2; 
    //make ball speed faster 
    xspeed += 2;
    yspeed += 2;
    ballX = 600;
    ballY = 400;
    //make the paddle length shorter 
    if (l > 20)
    {
      l -= 10;
    }
  }
  //reset whether game is lost or won if mouseclicked
  if (score2 >= 20) {
    textSize(48);
    text("PLAYER 2 WINS", 690, 400);
    text("Click mouse for a rematch", 530, 500);
    if (mousePressed) {
      reset();
    }
  }    
  if (score1 >= 20) {
    textSize(48);
    text("PLAYER 1 WINS", 690, 400);
    if (mousePressed) {
      reset();
    }
  }


  //instructions
  textSize(18);
  text("Press 'H' for help", 1020, 40);
  if (keyPressed && key == 'h') {
    background(340, 30, 150);
    textSize(24);
    text("Welcome to Catherine's PONG game!", 100, 60);
    text("TRAINING MODE: Your goal is to receive the ball 40 consecutive times", 100, 140);
    text("while the ball gets faster and the paddle gets shorter!", 100, 185);
    text("SINGLE-PLAYER MODE: Verse the computer and win!", 100, 260);
    text("MULTIPLAYER MODE: Verse your friend (or yourself) and win!", 100, 305);
    text("CONTROLS: UP and DOWN arrow keys to move left paddle for 1 player", 100, 360);
    text("CONTROLS: 'w' and 's' arrow keys to move right paddle for 2 player", 100, 405);
    text("Press 't' for training, '1' for single-player and 'm' for multiplayer", 100, 455);
  }
}
