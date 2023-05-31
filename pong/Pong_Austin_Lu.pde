/* ***********************************************************************
* Austin Lu
* Pong
* CompSci 10
* 11/26/2020
Use A&D keys or arrow keys to move the paddle. 
Difficulty is based on ai detection size.
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
int vX=10; //ball velocity X
int vY=10; //ball velocity Y
int pX=350; //player paddle X
int pY=600; //player paddle Y
int aX=350; //opponent paddle X
int aY=100; //opponent paddle Y
int aVX=15; //opponent paddle move speed
int pScore=0; //player score value
int aScore=0; //opponent score value
int detectSize=350; //main factor of difficulty
int buttonDilate=0; //used for button animation
int difficulty=0; //difficulty modifier
String[] buttons={"EASY","MEDIUM","HARD"};
int gameStart=0; //init variable
void midline(){
 smooth();
 for(int i=1;i<700;i+=14){
   stroke(255);
   line(i,350,i+4,350);
 }
}
void ballRender(){
  smooth();
  noStroke();
  
  for(int i=1; i<1000; i+=1){
    fill(250,255-i);
    circle(x-vX/i,y-vY/i,10-i/1000);
  }
  x+=vX;
  y+=vY;
    if(x>=700 || x<=0){ // bounce calculation X
    vX = -vX;
    x += vX*2;
    y += vY*2;
  }
  if(y>=700 || y <=0){ // bounce calculation Y
   if(y>=700){ // Score calculation part 1
    aScore+=1;
    }
    if(y<=0){
      pScore+=1; // Score calculation part 2
    }
    vY=-vY;
    x += vX*2;
    y += vY*2;
  }
   
  if(x>=pX-10 && x<=pX+90){ //X PaddleBounce 1
    if(y>= pY && y <= pY+20){
      vY=-vY;
      x+=vX*2;
      y+=vY*2;
    }
  }

  if(x>=aX-10 && x<=aX+90){ //X PaddleBounce 2
    if(y>= aY && y <= aY+20){
      vY=-vY;
      x+=vX*2;
      y+=vY*2;
    }
  }

}
void key() { //controls for the player's paddle
  if((key=='d'||keyCode ==RIGHT)&&pX<=650) {
    pX+=15;
  }else if((key=='a'||keyCode ==LEFT)&&pX>=0) {
    pX-=15;
  }
}
void player(){
if(keyPressed){
  key();
}
 noStroke();
 fill(250,255);
 rect(pX,pY,70,15);

}
void ai() {
   noStroke();
 fill(250,255);
 rect(aX,aY,70,15);
 if(y<detectSize && y>50){
 if(x>aX){
   aX+=aVX;
 }
 if(x<aX){
   aX-=aVX;
 }
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
    gameStart=2;
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
void draw(){
  background(0);
  print("DetectSize:",detectSize,"Difficulty:",difficulty,"          ");
  //font=loadFont("OCRAExtended-48.vlw");
  //textFont(font);
  if(mousePressed && gameStart==0){
    gameStart=1;
    
  }
  if(gameStart==2){
  ballRender();
  player();
  ref();
  midline();
  if(difficulty==0){
    detectSize=300;
  }else if(difficulty==1){
    detectSize=400;
  }else if(difficulty==2){
    detectSize=500;
  }
  ai();
  fill(250,255);
  textSize(30);
    text(pScore,600,500);
    text(aScore,600,200);
  }else if(gameStart==0){
    textSize(64);
    fill(250,255);
    text("PONG",350,300);
    textSize(32);
    fill(250,255);
    text("Click anywhere to start",350,350);
    if(mousePressed){
      gameStart=1;
    }
  }else if(gameStart==1){
    x=300;
    y=300;
    pX=350;
    pY=600;
    aX=350;
    aY=100;
    textSize(32);
    fill(250,255);
    text("Select Difficulty",200,150);
    difficulty();
  }else if(gameStart==3){ // Win screen
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
  }else if(gameStart==4){
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
}
