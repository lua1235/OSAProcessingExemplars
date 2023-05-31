/* ***********************************************************************
* Austin Lu
* Table Tennis
* CompSci 10
* 1/14/2021
  More than anything, this was a bit of an experiment to try and simulate 3d in 2d
* This program is my own work - A.L.   */
//PFont font;
void setup(){
  size(700,700);
  background(0);
  ellipseMode(RADIUS);
  textAlign(CENTER);
}
int x=300; //ball position X
int y=300; //ball position Y 
int z=300; //ball position Z
int vX=0; //ball velocity X
float vY=0; //ball velocity Y
float vYGrav=0.1; //ball velocity Y gravity effect
int vZ=5; //ball velocity Z
int aX=300; //ai paddle position X
int aY=300; //ai paddle position Y
float easing=0.3; //dampener for ai paddle
int pScore=0; //player score value
int aScore=0; //opponent score value
int detectSize=450; //main factor of difficulty
int buttonDilate=0; //used for button animation
int difficulty=0; //difficulty modifier
String[] buttons={"EASY","MEDIUM","HARD"};
int gameStart=0; //init variable
int countDown=3;
int scoreSide=0; //I'm going to get confused, so 0 is ai point, 1 is also ai point, 2 is player point, and 3 is also player point.
void draw(){
  background(0);
  //print("DetectSize:",detectSize,"Difficulty:",difficulty,"          ");
  //font=loadFont("OCRAExtended-48.vlw");
  //textFont(font);
  if(mousePressed && gameStart==0){
    gameStart=1;
    
  }
  if(gameStart==2){ //Actual gameplay program
    fill(250,255);
    text(str(pScore)+":"+str(aScore), 350,200);
    ref();
    paddle2();
    table();
    shadow();
    if(z>=350){
    net();
    ball();
    }else{
      ball();
      net();
    }
    paddle1();
    if(z>=770){
      ball();
    }
  }else if(gameStart==0){ // Title page
    textSize(64);
    fill(250,255);
    text("Table Tennis",350,300);
    textSize(32);
    fill(250,255);
    text("Click anywhere to start",350,350);
    if(mousePressed){
      gameStart=1;
    }
  }else if(gameStart==1){
    textSize(32);
    fill(250,255);
    text("Select Difficulty",200,150);
    text("Press h for rules",500,100);
    difficulty();
  }else if(gameStart==3){ // Win screen
    win();
  }else if(gameStart==4){
    lose();
  }else if(gameStart==5){ //countdown
    x=300+int(random(101)); //ball position X
    y=200; //ball position Y 
    z=300; //ball position Z
    vX=0; //ball velocity X
    vY=10; //ball velocity Y
    vYGrav=0.2; //ball velocity Y gravity effect
    vZ=5; //ball velocity ZSide=0;
    scoreSide=4; //resets the score side
    text(str(countDown),350,350);
    delay(1000);
    countDown-=1;
    if(countDown<0){
    gameStart=2;
    countDown=3;
    }
  }
  rules();
}
void paddle2(){ //Opponent's paddle
  stroke(30,30,180,255); 
  strokeWeight(3);
  fill(29,29,206,255);
   rect(aX-20,aY-20,20,20);
   rect(aX-20,aY,20,20);
   rect(aX,aY-20,20,20);
   rect(aX,aY,20,20);
   // smooth movement
if(difficulty==0){
  detectSize=450;
}else if(difficulty==1){
  detectSize=350;
}else if(difficulty==2){
  detectSize=250;
}
if(z<=detectSize && scoreSide!=0){
 float targetX = x;
  float dx = targetX - aX;
  if(dx>=5){
    dx=5;
  }else if(dx<=-5){
    dx=-5;
  }
  aX += dx * easing;
  
  float targetY = y;
  float dy = targetY - aY;
  if(dy>=5){
    dy=10;
  }else if(dy<=-10){
    dy=-5;
  }
  aY += dy * easing;
}
}
void paddle2Y(){
  if(y>=250){
    vY=-4;
    y+=vY*2;
  }
}
void paddle2X(){
  int dir=int(random(2));
  if(dir==0){
    vX=2;
    x+=vX*2;
  }else if(dir==1){
    vX=-2;
    x+=vX*2;
  }
}
void collisions() { // Z axis collisions
  if(z>=750 && z<=770 && x>=mouseX-50 && x<=mouseX+50 && y>=mouseY-50 && y<=mouseY+50){ // Z collision playerside
    paddle1X();
    paddle1Y();
    vZ=-vZ;
    z+=vZ*4;
  }else if(z<=150 && z>=130 &&  x>=aX-20 && x<=aX+20 && y>=aY-20 && y<=aY+20){ // Z collision Opponentside
    paddle2X();
    paddle2Y();
    vZ=-vZ;
    z+=vZ*4;
  }else if(z>=900 || z<=120){
    if(scoreSide==2 || scoreSide==3){
      pScore+=1;
      scoreSide=4;
    }else if(scoreSide==1 || scoreSide==0){
      aScore+=1;
      scoreSide=4;
    }
    gameStart=5;
  }
  int tableLength=610-((750-z)/2); //I'm quite proud of this. It splits the Y collision into increments based on the Z position.
  if(y>=tableLength){ //table collisions
     if(scoreSide==0){ //very important: determines which side will score
      if(z<=450){ // I know I could include this into the line above, but I'm splitting it to make it easier for me.
        scoreSide=1;
      }
    }else if(scoreSide==1){
      if(z<=450){ //Spent quite a bit of time coming up with this logic. Works in my head, hard to explain without a diagram, though.
        scoreSide=2;
      }else if(z>=450){
        scoreSide=0;
      }
    }else if(scoreSide==2){
      if(z>=450){
        scoreSide=1;
      }else if(z<=450){
        scoreSide=3;
      }
    }else if(scoreSide==3){
      if(z>=450){ //this and the first one are handy little things that determine all the different possible penalties.
        scoreSide=2;
      }
    }else if(scoreSide==4){
      if(z<=450){
        scoreSide=1;
      }
    }
    vY=-5;
    y+=vY*2;
  }
}
void boundaries() { //determines when the ball goes out of bounds
  int boundLeft=290-((z-150)/3);
  int boundRight=410+((z-150)/3);
  print("("+str(boundLeft)+","+str(boundRight)+","+str(x)+")");
  if(x<=boundLeft || x>=boundRight){
    print("trigger ");
   vX=-vX;
   x+=vX*10;
  }
}
void shadow(){ //creates shadow to indicate Z position
  noStroke();
  fill(0,0,0,100);
  ellipse(x,610-((750-z)/2),z/50,z/100);
}
void table() {
  strokeWeight(10);
  stroke(255);
  fill(22,200,100);
  beginShape(); //start of the trapezoid that creates the table's surface
  vertex(90,610);
  vertex(610,610);
  vertex(450,310);
  strokeWeight(5);
  vertex(250,310);
  strokeWeight(10);
  vertex(90,610);
  endShape(); //end of the trapezoid that creates the table's surface
  fill(127,127,127);
  rect(90,620,525,20); //thickness of table
}
void net() { //creates the net
  stroke(250);
  strokeWeight(3);
   for(int i=0; i<=40; i++){
    line(190+8*i,420,190+8*i,370); //vertical net lines
  }
  for(int p=0; p<=6; p++){
    line(190,420-8*p,510,420-8*p); //horizontal net lines
  }
}
void ball() {
  if(scoreSide==0){
    fill(0,0,255);
  }else if(scoreSide==3){
    fill(255,0,0);
  }else{
  fill(255);
  }
  noStroke();
  circle(x,y,z/50);
  y+=vY;
  z+=vZ;
  x+=vX;
  vY+=vYGrav;
  collisions();
  boundaries();
}
//Determines the exact physics of the bounces off the paddle
void paddle1(){ //player's paddle
 if(x>=mouseX-50 && x<=mouseX+50 && y>=mouseY-50 && y<=mouseY+50){
  stroke(188,30,30,100); 
  strokeWeight(3);
  fill(206,29,29,100);
 }else{
   stroke(188,30,30,255); 
  strokeWeight(3);
  fill(206,29,29,255);
 }
   rect(mouseX-50,mouseY-50,50,50);
   rect(mouseX-50,mouseY,50,50);
   rect(mouseX,mouseY-50,50,50);
   rect(mouseX,mouseY,50,50);
}
void paddle1X(){ //bouncing is based on the sectors on the paddle
  if(x>=mouseX && x<=mouseX+50){
    stroke(247,247,42,100); 
  strokeWeight(3);
  fill(206,29,29,100);
    vX=2;
    x+=vX*2;
  }else if(x>=mouseX-50 && x<=mouseX){
     stroke(247,247,42,100); 
  strokeWeight(3);
  fill(206,29,29,100);
    vX=-2;
    x+=vX*2;
  }
}
void paddle1Y(){
   if(y>=350){
    vY=-10;
    y+=vY*2;
  }
}
void difficulty() {
  strokeWeight(5);
  for(int i=0; i<3; i++){
  stroke(255,255);
  fill(0);
  buttonDilate=0;
  if(mousePressed && mouseX>=200 && mouseX<=300 && mouseY>=200+i*100 && mouseY<=250+i*100){ //Detects click
    difficulty=i;
  }else if(mouseX>=200 && mouseX<=300 && mouseY>=200+i*100 && mouseY<=250+i*100){ //Detects mouseover
    buttonDilate+=10;
  }
  if(difficulty==i){
    stroke(255);
    fill(255);
  }
  rect(200,200+i*100,100+buttonDilate,50+buttonDilate); //Draws each button
    if(difficulty==i){
    stroke(255);
    fill(0);
  }else{
    fill(255);
  }
  textSize(20);
  text(buttons[i],250,225+i*100); //Pulls the correct button name out of the array
  }
  stroke(255);
  fill(0);
   buttonDilate=0;
  if(mousePressed&&mouseX>=500&&mouseX<=600&&mouseY>=600&&mouseY<=650){ //Detects click
    gameStart=5;
  }else if(mouseX>=500&&mouseX<=600&&mouseY>=600&&mouseY<=650){ //Detects mouseover
    buttonDilate+=10;
  }
  rect(500,600,100+buttonDilate,50+buttonDilate);
  textSize(20);
  fill(255);
  text("Play",550,625);
}
void ref() { // The referee
  if(pScore>=10){
    gameStart=3;
  }else if(aScore>=10){
    gameStart=4;
  }
}
void win(){
   textSize(32);
    fill(250,255);
    if(pScore-aScore>10){ // Reactive ending message 1
    text("You're a cheater, aren't you", 350,200);
    }else if(pScore-aScore>=5 && difficulty!=2){
    text("You're pretty good",350,200);
    text("Try something harder next time",350,250);
    }else if(pScore-aScore>=5 && difficulty ==2){
    text("You're either really good",350,200);
    text("Or a cheater",350,250);
    }else{
    text("Not bad",350,200);
    }
    text("You win "+str(pScore)+":"+str(aScore),350,150);
    text("Click anywhere to start again",350,300);
     if(mousePressed){
      gameStart=1;
      pScore=0;
      aScore=0;
    }
}
void lose(){
   textSize(32);
    fill(250,255);
    if(aScore-pScore>=10){ // Reactive ending message 2
    text("Um, nice try?", 350,200);
    }else if(aScore-pScore>=5 && difficulty !=0){
    text("Try something easier next time",350,200);
    }else if(aScore-pScore>=5 && difficulty ==0){
    text("this probably isn't",350,200);
    text("the game for you",350,250);
    }
    text("You lost "+str(pScore)+":"+str(aScore),350,150);
    text("Click anywhere to start again",350,300);
     if(mousePressed){
      gameStart=1;
      pScore=0;
      aScore=0;
    }
}
void rules(){ //displays rules
  if(keyPressed){
  if(key=='h' || key=='H'){
  fill(0,0,0,200);
  rect(0,0,750,750);
  textSize(20);
  fill(255);
  text("Rules",100,50);
  text("This game follows a simplified version",350,100);
  text(" of the actual pong rules",350,125);
  text("You control the red paddle with your mouse,",350,175);
  text("while the computer controls the blue paddle",350,200);
  text("The ball must bounce once on the opponent's side",350,250);
  text("In order for you to score normally",350,275);
  text("Sometimes, the ball will change color.",350, 325);
  text("This indicates a foul, and you don't have to recieve",350,350);
  text("the ball if it is the same color as your paddle",350,375);
  text("The ball will not go out of bounds from the sides",350,425);
  text("of the table, by virtue of two invisible walls",350,450);
  text("This is to make the games last longer, as you don't",350,475);
  text("have as much control as you would in real life.",350,500);
  text("Similarily, the vertical bounces off of your paddle",350,550);
  text("are predetermined, while the horizontal bounces are",350,575);
  text("determined by which side of the paddle the ball hits",350,600);
  }
}
}
