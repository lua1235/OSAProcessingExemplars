/* ***********************************************************************
 * Caleb Ji
 * Assignment 2 - Paint by Dot
 * CS 10
 * Friday, April 19 2020
 
 * This program is my own work - CJ  */

// colour currently in use
float r = 0;
float g = 0;
float b = 0; 

// colour selected in rainbow selector
float rSelect = 134;
float gSelect = 234;
float bSelect = 93;

// size of dot, type of brush and tool
float dotSize = 10;
float shapeDotSize = 10; // size of dots fro shapes, can't change
String shape = "dot";
String[] shapes = {"dot", "circle", "triangle", "square"};
String tool = "pencil";
String[] tools = {"pencil", "spraycan", "eraser"};
float sprayCanVariations [] = {0, 0, dotSize, dotSize, -dotSize, 2* dotSize, -2*dotSize, -3*dotSize, 2*dotSize, -2*dotSize, -1.5*dotSize, - 0.5 * dotSize, 2.5 * dotSize, 2.5 * dotSize}; //for the "random" dot effect in spray can

Boolean startTransferDelay = false; //transfer delay, ensures no painting when closing windows
int transferDelayTimer = 0;
Boolean dotWorks = true;
// to see what mouse is doing
Boolean drawing = false;
Boolean undoing = false;
Boolean mouseOnSlider = false;
Boolean mouseOnRedSlider = false;
Boolean mouseOnGreenSlider = false;
Boolean mouseOnBlueSlider = false;
//what's open
Boolean colourMenuOpen = false;
Boolean shapeMenuOpen = false;
Boolean toolMenuOpen = false;
Boolean rainbowMenuOpen = false;
PImage rainbow;
//timer until undo starts rapid deleting
int undoWaitTimer = 0;
//sliders
float sliderX = 170;
float redSliderX = 506.5;
float greenSliderX = 606.5;
float blueSliderX = 465.5;

float colours [] = {255, 0, 0, 255, 165, 0, 255, 223, 0, 0, 255, 0, 0, 0, 255, 75, 0, 130, 0, 0, 0, 139, 69, 19, rSelect, gSelect, bSelect}; // different colours in colour selector
int colourSelected = 6; // which index in colours [] is selected
//list of all information about the dots
FloatList dotInfor;
int dotPlacedOrder = 0;


void setup() {
  size(1000, 700);
  background(255);
  dotInfor = new FloatList(); //initialize list
  rainbow = loadImage("https://www.script-tutorials.com/demos/315/images/colorwheel1.png"); // initialize image
}

void draw() {
  background(255);
  println(mouseX, mouseY);
  // to see if transfer delay is active
  if (startTransferDelay) {
    transferDelayTimer += 1;
    if (transferDelayTimer >= 10) {
      startTransferDelay = false;
      transferDelayTimer = 0;
    }
  }
  // main mouse press system, for all dot creating activity
  if (mousePressed) {
    dotWorks = true;
    if (!colourMenuOpen && !startTransferDelay && !shapeMenuOpen && !undoing && !toolMenuOpen && !rainbowMenuOpen) { // makes sure nothing is open
      if (shape == "dot") {
        check(0); // check
        if (dotWorks) {
          //create the dots based on tool
          if (tool == "pencil") {
            dotAppend(float(mouseX), float(mouseY), dotSize, false);
            drawing = true;
          } else if (tool == "spraycan") {
            for (int i = 0; i <= 6; i += 1) {
              dotAppend(mouseX + sprayCanVariations[2+i], mouseY + sprayCanVariations[2*i+1], dotSize, false);
            }
            drawing = true;
          } else if (tool == "eraser") {
            dotAppend(float(mouseX), float(mouseY), dotSize, true);
            drawing = true;
          }
          dotPlacedOrder += 1;
        }
      } else if (shape == "circle") {
        check(0); // check
        if (dotWorks) {
          //creates dot based on tool
          if (tool == "pencil") {
            for (int i = 0; i <= 360; i += 4320/(PI * 4 * dotSize)) {
              float x = cos(radians(i))* dotSize * 2; // these floats are to make the circle circular
              float y = sin(radians(i))*dotSize * 2;
              dotAppend(mouseX + x, mouseY + y, shapeDotSize, false);
            }
            drawing = true;
          } else if (tool == "spraycan") {
            for (int j = 0; j <= 6; j += 1) {
              for (int i = 0; i <= 360; i += 4320/(PI * 4 * dotSize)) {
                float x = cos(radians(i))* dotSize * 2;
                float y = sin(radians(i))*dotSize * 2;
                dotAppend(mouseX + 2*sprayCanVariations[2*j]+ x, mouseY + 2*sprayCanVariations[2*j+1] +y, shapeDotSize, false);
              }
            }
            drawing = true;
          } else if (tool == "eraser") {
            for (int i = 0; i <= 360; i += 4320/(PI * 4 * dotSize)) {
              if (dotWorks) {
                float x = cos(radians(i))* dotSize * 2;
                float y = sin(radians(i))*dotSize * 2;
                dotAppend(mouseX + x, mouseY + y, shapeDotSize, true);
                drawing = true;
              }
            }
          }
          dotPlacedOrder += 1;
        }
      } else if (shape == "triangle") {
        float thing = dotSize*3/sqrt(3); // math thingy constant
        check(0); // check
        if (dotWorks) {
          if (tool == "pencil") {
            //initial three corners
            dotAppend(mouseX, mouseY - dotSize * 2, shapeDotSize, false);
            dotAppend(mouseX + thing, mouseY + dotSize, shapeDotSize, false);
            dotAppend(mouseX - thing, mouseY + dotSize, shapeDotSize, false);
            //creating three edges at the same time
            for (int i = 0; i < dist(mouseX, mouseY - dotSize * 2, mouseX- thing, mouseY + dotSize)/12; i ++) {
              dotAppend(mouseX + 6*i, mouseY - dotSize * 2 + 6*sqrt(3) * i, shapeDotSize, false);
              dotAppend(mouseX - 6*i, mouseY - dotSize * 2 + 6*sqrt(3) * i, shapeDotSize, false);
              dotAppend(mouseX - thing + 12 * i, mouseY + dotSize, shapeDotSize, false);
              drawing = true;
            }
          } else if (tool == "spraycan") {
            for (int j = 0; j <= 6; j += 1) {
              //initial three corners
              dotAppend(mouseX + 2*sprayCanVariations[2*j], mouseY + 2*sprayCanVariations[2*j + 1] - dotSize * 2, shapeDotSize, false);
              dotAppend(mouseX + 2*sprayCanVariations[2*j] + thing, mouseY + 2*sprayCanVariations[2*j + 1] + dotSize, shapeDotSize, false);
              dotAppend(mouseX + 2*sprayCanVariations[2*j] - thing, mouseY + 2*sprayCanVariations[2*j + 1] + dotSize, shapeDotSize, false);
              //creating three edges at the same time
              for (int i = 0; i < dist(mouseX + 2*sprayCanVariations[2*j], mouseY + 2*sprayCanVariations[2*j + 1] - dotSize * 2, mouseX + 2* sprayCanVariations[2*j]- thing, mouseY + 2*sprayCanVariations[2*j + 1] + dotSize)/12; i ++) {
                dotAppend(mouseX + 2*sprayCanVariations[2*j] + 6*i, mouseY + 2*sprayCanVariations[2*j + 1] - dotSize * 2 + 6*sqrt(3) * i, shapeDotSize, false);
                dotAppend(mouseX + 2*sprayCanVariations[2*j] - 6*i, mouseY + 2*sprayCanVariations[2*j + 1] - dotSize * 2 + 6*sqrt(3) * i, shapeDotSize, false);
                dotAppend(mouseX + 2*sprayCanVariations[2*j] - thing + 12 * i, mouseY + 2*sprayCanVariations[2*j + 1] + dotSize, shapeDotSize, false);
                drawing = true;
              }
            }
          } else if (tool == "eraser") {
            dotAppend(mouseX, mouseY - dotSize * 2, shapeDotSize, true);
            dotAppend(mouseX + thing, mouseY + dotSize, shapeDotSize, true);
            dotAppend(mouseX - thing, mouseY + dotSize, shapeDotSize, true);
            for (int i = 0; i < dist(mouseX, mouseY - dotSize * 2, mouseX- thing, mouseY + dotSize)/12; i ++) {
              dotAppend(mouseX + 6*i, mouseY - dotSize * 2 + 6*sqrt(3) * i, shapeDotSize, true);
              dotAppend(mouseX - 6*i, mouseY - dotSize * 2 + 6*sqrt(3) * i, shapeDotSize, true);
              dotAppend(mouseX - thing + 12 * i, mouseY + dotSize, shapeDotSize, true);
              drawing = true;
            }
          }
          dotPlacedOrder += 1;
        }
      } else if (shape == "square") {
        float thing = sqrt(2) * dotSize; // math constant
        check(0);//check
        if (dotWorks) {
          if (tool == "pencil") {
            //creating four corners
            dotAppend(mouseX + thing, mouseY +thing, shapeDotSize, false);
            dotAppend(mouseX - thing, mouseY +thing, shapeDotSize, false);
            dotAppend(mouseX + thing, mouseY -thing, shapeDotSize, false);
            dotAppend(mouseX - thing, mouseY -thing, shapeDotSize, false);
            // creating all four sides at the same time
            for (int i = 0; i < dist(mouseX + thing, mouseY + thing, mouseX + thing, mouseY - thing) / 12; i ++) {
              dotAppend(mouseX + thing, mouseY +thing - 12 * i, shapeDotSize, false);
              dotAppend(mouseX - thing, mouseY +thing - 12 * i, shapeDotSize, false);
              dotAppend(mouseX + thing - 12 * i, mouseY +thing, shapeDotSize, false);
              dotAppend(mouseX + thing - 12 * i, mouseY -thing, shapeDotSize, false);
              drawing = true;
            }
          } else if (tool == "spraycan") {
            for (int j = 0; j <= 6; j += 1) {
              dotAppend(mouseX + 2*sprayCanVariations[2*j] + thing, mouseY + 2*sprayCanVariations[2*j + 1] +thing, shapeDotSize, false);
              dotAppend(mouseX + 2*sprayCanVariations[2*j] - thing, mouseY + 2*sprayCanVariations[2*j + 1] +thing, shapeDotSize, false);
              dotAppend(mouseX + 2*sprayCanVariations[2*j] + thing, mouseY + 2*sprayCanVariations[2*j + 1] -thing, shapeDotSize, false);
              dotAppend(mouseX + 2*sprayCanVariations[2*j] - thing, mouseY + 2*sprayCanVariations[2*j + 1] -thing, shapeDotSize, false);
              for (int i = 0; i < dist(mouseX + 2*sprayCanVariations[2*j] + thing, mouseY + 2*sprayCanVariations[2*j + 1] + thing, mouseX + 2*sprayCanVariations[2*j] + thing, mouseY + 2*sprayCanVariations[2*j + 1] - thing) / 12; i ++) {
                dotAppend(mouseX + 2*sprayCanVariations[2*j] + thing, mouseY + 2*sprayCanVariations[2*j + 1] +thing - 12 * i, shapeDotSize, false);
                dotAppend(mouseX + 2*sprayCanVariations[2*j] - thing, mouseY + 2*sprayCanVariations[2*j + 1] +thing - 12 * i, shapeDotSize, false);
                dotAppend(mouseX + 2*sprayCanVariations[2*j] + thing - 12 * i, mouseY + 2*sprayCanVariations[2*j + 1] +thing, shapeDotSize, false);
                dotAppend(mouseX + 2*sprayCanVariations[2*j] + thing - 12 * i, mouseY + 2*sprayCanVariations[2*j + 1] -thing, shapeDotSize, false);
                drawing = true;
              }
            }
            drawing = true;
          } else if (tool == "eraser") {
            dotAppend(mouseX + thing, mouseY +thing, shapeDotSize, false);
            dotAppend(mouseX - thing, mouseY +thing, shapeDotSize, false);
            dotAppend(mouseX + thing, mouseY -thing, shapeDotSize, false);
            dotAppend(mouseX - thing, mouseY -thing, shapeDotSize, false);
            for (int i = 0; i < dist(mouseX + thing, mouseY + thing, mouseX + thing, mouseY - thing) / 12 + 1; i ++) {
              dotAppend(mouseX + thing, mouseY +thing - 12 * i, shapeDotSize, true);
              dotAppend(mouseX - thing, mouseY +thing - 12 * i, shapeDotSize, true);
              dotAppend(mouseX + thing - 12 * i, mouseY +thing, shapeDotSize, true);
              dotAppend(mouseX + thing - 12 * i, mouseY -thing, shapeDotSize, true);
              drawing = true;
            }
          }
          dotPlacedOrder += 1;
        }
      }
    }
  }
  //"printing" out all the dots based on the information from dotInfor
  for (int i = 0; i <= dotInfor.size() / 7 - 1; i ++ ) {
    fill(dotInfor.get(7*i + 3), dotInfor.get(7*i + 4), dotInfor.get(7*i + 5));
    ellipse(dotInfor.get(7*i), dotInfor.get(7*i + 1), dotInfor.get(7*i + 2), dotInfor.get(7*i + 2));
  }
  noStroke();

  //colour selector button
  fill(r, g, b);
  ellipse(80, 620, 50, 50);
  fill(255);
  ellipse(80, 620, 45, 45);
  fill(r, g, b);
  ellipse(80, 620, 40, 40);

  //tool selector button
  fill(r, g, b);
  ellipse(155, 620, 50, 50);
  fill(255);
  ellipse(155, 620, 45, 45);
  stroke(r, g, b);
  strokeWeight(2);
  if (tool == "pencil") {
    //pencil icon
    line(162, 618, 162, 640);
    line(148, 618, 148, 640);
    line(155, 618, 155, 643);
    triangle(162, 618, 148, 618, 155, 605);
    fill(r, g, b);
    triangle(155, 605, 153, 609.3, 157.3, 609.3);
  } else if (tool == "spraycan") {
    //spraycan icon
    line(165, 623, 165, 640);
    line(145, 623, 145, 640);
    fill(255);
    arc(155, 623, 20, 20, PI, PI*2, PIE);
    rect(152.5, 608, 5, 5);
  } else if (tool == "eraser") {
    //eraser icon
    line(165, 623, 165, 640);
    line(145, 623, 145, 640);
    rect(145, 613, 20, 10, 2);
  }
  noStroke();

  //shapes selector button 
  fill(r, g, b);
  ellipse(230, 620, 50, 50);
  fill(255);
  ellipse(230, 620, 45, 45);
  if (shape == "dot") {
    //dot icon
    fill(r, g, b);
    ellipse(230, 620, 20, 20);
  } else if (shape == "circle") {
    //circle icon
    fill(r, g, b);
    ellipse(230, 620, 30, 30);
    fill(255);
    ellipse(230, 620, 25, 25);
  } else if (shape == "triangle") {
    //triangle icon
    strokeWeight(2);
    stroke(r, g, b);
    line(230, 605, 217, 627.5);
    line(230, 605, 243, 627.5);
    line(243, 627.5, 217, 627.5);
    noStroke();
  } else if (shape == "square") {
    //square icon
    strokeWeight(2);
    stroke(r, g, b);
    line(240.6, 630.6, 240.6, 609.4);
    line(240.6, 630.6, 219.4, 630.6);
    line(219.4, 609.4, 240.6, 609.4);
    line(219.4, 609.4, 219.4, 630.6);
    noStroke();
  }

  //colourMenu
  if (colourMenuOpen) {
    noStroke();
    fill(#f5f5dc);
    rect(100, 495, 455, 40, 20);
    rect(50, 515, 555, 60, 10);
    triangle(80, 590, 75, 575, 85, 575);
    // selections
    for (int i = 0; i <= colours.length /3 - 1; i ++) {
      fill(colours[3*i], colours[3*i+1], colours[3*i +2]);
      ellipse(55 * i + 80, 545, 50, 50);
      if (colourSelected == i) {
        fill(255);
        ellipse(55 * i + 80, 545, 45, 45);
        fill(colours[3*i], colours[3*i+1], colours[3*i +2]);
        ellipse(55 * i + 80, 545, 40, 40);
      }
    }

    image(rainbow, 550, 520, 53, 53);

    //slider 
    if (mouseOnSlider) {
      if (mouseX >= 150 && mouseX <= 505) {
        sliderX = mouseX;
      } else if (mouseX < 150) {
        sliderX = 150;
      } else {
        sliderX = 505;
      }
      dotSize = floor(((sliderX - 150)/ (355/95)) + 5);
      // changing the sizes of the spraycan
      float newSprayCanVariations [] = {0, 0, dotSize, dotSize, -dotSize, 2* dotSize, -2*dotSize, -3*dotSize, 2*dotSize, -2*dotSize, -1.5*dotSize, - 0.5 * dotSize, 2.5 * dotSize, 2.5 * dotSize};
      sprayCanVariations = newSprayCanVariations;
      fill(r, g, b);
      // the image that shows when changing the size to help with visualization
      if (shape == "dot") {
        ellipse( 327.5, 385, dotSize, dotSize);
      } else if (shape == "circle") {
        for (int i = 0; i <= 360; i += 4320/(PI * 4 * dotSize)) {
          float x = cos(radians(i))* dotSize * 2;
          float y = sin(radians(i))*dotSize * 2;
          ellipse(327.5 + x, 385 + y, shapeDotSize, shapeDotSize);
        }
      } else if (shape == "triangle") {
        float thing = dotSize*3/sqrt(3);
        ellipse(327.5, 385 - dotSize * 2, shapeDotSize, shapeDotSize);
        ellipse(327.5 + thing, 385 + dotSize, shapeDotSize, shapeDotSize);
        ellipse(327.5- thing, 385+ dotSize, shapeDotSize, shapeDotSize);
        for (int i = 0; i < dist(mouseX, mouseY - dotSize * 2, mouseX- thing, mouseY + dotSize)/12; i ++) {
          ellipse(327.5 + 6*i, 385 - dotSize * 2 + 6*sqrt(3) * i, shapeDotSize, shapeDotSize);
          ellipse(327.5 - 6*i, 385 - dotSize * 2 + 6*sqrt(3) * i, shapeDotSize, shapeDotSize);
          ellipse(327.5- thing + 12 * i, 385+ dotSize, shapeDotSize, shapeDotSize);
        }
      } else if ( shape == "square") {
        float thing = sqrt(2) * dotSize;
        ellipse(327.5 + thing, 385 +thing, shapeDotSize, shapeDotSize);
        ellipse(327.5 - thing, 385 +thing, shapeDotSize, shapeDotSize);
        ellipse(327.5 + thing, 385  -thing, shapeDotSize, shapeDotSize);
        ellipse(327.5 - thing, 385 -thing, shapeDotSize, shapeDotSize);
        for (int i = 0; i < dist(mouseX + thing, mouseY + thing, mouseX + thing, mouseY - thing) / 12; i ++) {
          ellipse(327.5 + thing, 385 +thing - 12 * i, shapeDotSize, shapeDotSize);
          ellipse(327.5 - thing, 385 +thing - 12 * i, shapeDotSize, shapeDotSize);
          ellipse(327.5 + thing - 12 * i, 385  +thing, shapeDotSize, shapeDotSize);
          ellipse(327.5 + thing - 12 * i, 385 -thing, shapeDotSize, shapeDotSize);
        }
      }
    }

    strokeWeight(1);
    stroke(0);
    line(150, 505, 505, 505);
    noStroke();
    fill(#BEBEBE);
    rect(sliderX, 500, 5, 10);
  } 

  //Tool selector
  if (toolMenuOpen) {
    noStroke();
    fill(#f5f5dc);
    rect(100, 515, 170, 60, 10);
    triangle(155, 590, 150, 575, 160, 575);
    fill(r, g, b);
    // selections
    if (tool == "pencil") {
      ellipse(130, 545, 50, 50);
    } else if (tool == "spraycan") {
      ellipse(185, 545, 50, 50);
    } else if (tool == "eraser") {
      ellipse(240, 545, 50, 50);
    }

    fill(255);
    ellipse(130, 545, 45, 45);
    ellipse(185, 545, 45, 45);
    ellipse(240, 545, 45, 45);


    strokeWeight(2);
    stroke(r, g, b);
    //pencil icon
    line(137, 543, 137, 565);
    line(123, 543, 123, 565);
    line(130, 543, 130, 568);
    triangle(137, 543, 123, 543, 130, 530);
    fill(r, g, b);
    triangle(130, 530, 128, 534.3, 132.3, 534.3);
    // sprayCan icon
    line(195, 548, 195, 565);
    line(175, 548, 175, 565);
    fill(255);
    arc(185, 548, 20, 20, PI, PI*2, PIE);
    rect(182.5, 533, 5, 5);
    //eraser
    line(230, 548, 230, 565);
    line(250, 548, 250, 565);
    rect(230, 538, 20, 10, 2);

    noStroke();
  }

  //shapeMenu
  if (shapeMenuOpen) {
    noStroke();
    fill(#f5f5dc);
    rect(150, 515, 225, 60, 10);
    triangle(230, 590, 225, 575, 235, 575);
    fill(r, g, b);
    //selections
    if (shape == "dot") {
      ellipse(180, 545, 50, 50);
    } else if (shape == "circle") {
      ellipse(235, 545, 50, 50);
    } else if (shape == "triangle") {
      ellipse(290, 545, 50, 50);
    } else if (shape == "square") {
      ellipse(345, 545, 50, 50);
    }
    fill(255);
    ellipse(180, 545, 45, 45);
    ellipse(235, 545, 45, 45);
    ellipse(290, 545, 45, 45);
    ellipse(345, 545, 45, 45);

    fill(r, g, b);
    //dot
    ellipse(180, 545, 20, 20);
    //circle
    ellipse(235, 545, 30, 30);
    fill(255);
    ellipse(235, 545, 25, 25);
    strokeWeight(2);
    //triangle
    stroke(r, g, b);
    line(303, 552.5, 290, 530);
    line(277, 552.5, 290, 530);
    line(303, 552.5, 277, 552.5);
    //square
    line(355.6, 555.6, 355.6, 534.4);
    line(355.6, 555.6, 334.6, 555.6);
    line(334.6, 534.6, 355.6, 534.6);
    line(334.6, 534.6, 334.6, 555.6);
    strokeWeight(0);
    noStroke();
  }
  //rainbow Menu

  if (rainbowMenuOpen) {
    noStroke();
    fill(#f5f5dc);
    rect(333, 140, 334, 280, 10);
    // red slider
    stroke(255, 0, 0);
    strokeWeight(2);
    line (372.5, 180, 627.5, 180);
    fill(40);
    textSize(10);
    textAlign(CENTER);
    text(str(int(rSelect)), 500, 170);
    stroke(#BEBEBE);
    fill(#BEBEBE);
    rect(redSliderX, 175, 5, 10);
    // green slider
    stroke(0, 255, 0);
    line (372.5, 240, 627.5, 240);
    fill(40);
    textSize(10);
    textAlign(CENTER);
    text(str(int(gSelect)), 500, 230);
    stroke(#BEBEBE);
    fill(#BEBEBE);
    rect(greenSliderX, 235, 5, 10);
    // blue slider
    stroke(0, 0, 255);
    line (372.5, 300, 627.5, 300);
    fill(40);
    textSize(10);
    textAlign(CENTER);
    text(str(int(bSelect)), 500, 290);
    stroke(#BEBEBE);
    fill(#BEBEBE);
    rect(blueSliderX, 295, 5, 10);
    // colour showbox
    noStroke();
    fill(rSelect, gSelect, bSelect);
    rect(450, 340, 100, 50, 10);

    //mouse on sliders
    //red
    if (mouseOnRedSlider) {
      if (mouseX >= 370 && mouseX <= 625) {
        redSliderX = mouseX;
      } else if  (mouseX > 625) {
        redSliderX =625;
      } else {
        redSliderX = 370;
      }
      rSelect = floor(redSliderX - 370);
    } else if (mouseOnGreenSlider) {
      //green
      if (mouseX >= 370 && mouseX <= 625) {
        greenSliderX = mouseX;
      } else if  (mouseX > 625) {
        greenSliderX = 625;
      } else {
        greenSliderX = 370;
      }
      gSelect = floor(greenSliderX - 370);
    } else if (mouseOnBlueSlider) {
      //blue
      if (mouseX >= 370 && mouseX <= 625) {
        blueSliderX = mouseX;
      } else if  (mouseX > 625) {
        blueSliderX =625;
      } else {
        blueSliderX = 370;
      }
      bSelect = floor(blueSliderX - 370);
    }
  }


  //undo
  stroke(255);
  strokeWeight(0);
  fill(#1391E8);
  ellipse(20, 20, 25, 25);
  noStroke();
  fill(255);
  triangle(20 - 20/3, 20, 20 + 10/3, 20 + 10/sqrt(3), 20 + 10/3, 20 - 10/sqrt(3));

  //undoing hold function
  if (undoing) {
    undoWaitTimer += 1;
    if (undoWaitTimer >= 30) {
      undo();
    }
  } else {
    undoWaitTimer = 0;
  }

  //drawing delay
  if (drawing) {
    delay(floor(dotSize / 5 + 20));
  }
}


void mousePressed() {
  // to click on the three circles on the bottom
  if (dist(mouseX, mouseY, 80, 620) <= 25 && !drawing) {
    // colour menu
    if (colourMenuOpen) {
      colourMenuOpen = false;
      startTransferDelay = true;
    } else {
      colourMenuOpen = true;
      shapeMenuOpen = false;
      toolMenuOpen = false;
      closeRainbowMenu();
    }
  } else if (dist(mouseX, mouseY, 230, 620) <= 25 && !drawing) {
    // shape menu
    if (shapeMenuOpen) {
      shapeMenuOpen = false;
      startTransferDelay= true;
    } else {
      shapeMenuOpen = true;
      colourMenuOpen = false;
      toolMenuOpen = false;
      closeRainbowMenu();
    }
  } else if (dist(mouseX, mouseY, 155, 620) <= 25 && !drawing) {
    //tool menu
    if (toolMenuOpen) {
      toolMenuOpen = false;
      startTransferDelay = true;
    } else {
      toolMenuOpen = true;
      colourMenuOpen = false;
      shapeMenuOpen = false;
      closeRainbowMenu();
    }
  }
  // functions inside colour menu
  if (colourMenuOpen) {
    // changing colour 
    for (int i = 0; i <= 8; i ++) {
      if (dist(mouseX, mouseY, 55*i + 80, 545) <= 25) {
        colourSelected = i;
        startTransferDelay = true;
        r = colours[3*i];
        g = colours[3*i + 1];
        b = colours[3*i + 2];
      }
    }
    //slider
    if (mouseX <= sliderX +5 && mouseX >= sliderX && mouseY <= 510 && mouseY >= 500) {
      mouseOnSlider = true;
    }
    // click outside menu to exit
    if ( !(mouseX <= 605 && mouseX >= 50 && mouseY <= 575 && mouseY >= 515)&& !(mouseX <= 555 && mouseX >= 100 && mouseY <= 535 && mouseY >= 495) ) {
      if (dist(mouseX, mouseY, 80, 620) >= 25) {
        colourMenuOpen = false;
        startTransferDelay = true;
      }
    }
    //press Rainbow selector
    if (dist(mouseX, mouseY, 575, 545) <= 25) {
      colourMenuOpen = false;
      rainbowMenuOpen = true;
    }
  } else if (shapeMenuOpen) {
    //changing shape
    for (int i = 0; i <= 3; i ++) {
      if (dist(mouseX, mouseY, 55*i + 180, 545) <= 25) {
        startTransferDelay = true;
        shape = shapes[i];
      }
    }
    // clikcing outside to exit
    if ( !(mouseX <= 375 && mouseX >= 150 && mouseY <= 575 && mouseY >= 515) ) {
      if (dist(mouseX, mouseY, 230, 620) >= 25) {
        shapeMenuOpen = false;
        startTransferDelay = true;
      }
    }
  } else if (toolMenuOpen) {
    // changing tool
    for (int i = 0; i <= 2; i ++) {
      if (dist(mouseX, mouseY, 55*i + 130, 545) <= 25) {
        startTransferDelay = true;
        tool = tools[i];
      }
    }
    //clicking outside to exit
    if ( !(mouseX <= 270 && mouseX >= 100 && mouseY <= 575 && mouseY >= 515) ) {
      if (dist(mouseX, mouseY, 155, 620) >= 25) {
        toolMenuOpen = false;
        startTransferDelay = true;
      }
    }
  } else if (rainbowMenuOpen) {
    //changing sliders
    if (mouseX <= redSliderX + 5 && mouseX >= redSliderX && mouseY >= 175 && mouseY <= 185) {
      mouseOnRedSlider = true;
    } else if (mouseX <= greenSliderX + 5 && mouseX >= greenSliderX && mouseY >= 235 && mouseY <= 245) {
      mouseOnGreenSlider = true;
    } else if (mouseX <= blueSliderX + 5 && mouseX >= blueSliderX && mouseY >= 295 && mouseY <=305) {
      mouseOnBlueSlider = true;
    }
    //clicking outside to exit
    if (!(mouseX<= 667 && mouseX >= 333 && mouseY <= 420 && mouseY >= 140)) {
      closeRainbowMenu();
      startTransferDelay = true;
    }
  }

  // clicking undo button
  if (!drawing) {
    if (dist(mouseX, mouseY, 20, 20) <= 12.5) {
      undoing = true;
      shapeMenuOpen = false;
      colourMenuOpen = false;
      undo();
    }
  }
}

void closeRainbowMenu () {
  // closing rainbow menu and setting the colours that are selected
  if (rainbowMenuOpen) {
    r = rSelect;
    g = gSelect;
    b = bSelect;
    colours[24] = rSelect;
    colours[25] = gSelect;
    colours[26] = bSelect;
    rainbowMenuOpen = false;
  }
}


void mouseReleased() {
  // exiting all mouse states when mouse released
  drawing = false;
  undoing = false;
  mouseOnSlider = false;
  mouseOnRedSlider = false;
  mouseOnGreenSlider = false;
  mouseOnBlueSlider = false;
}

void dotAppend(float xPos, float yPos, float size, Boolean isErase) {
  // to add info to dotInfor when drawing
  dotInfor.append(xPos);
  dotInfor.append(yPos);
  dotInfor.append(size);
  if (isErase) {
    dotInfor.append(255);
    dotInfor.append(255);
    dotInfor.append(255);
  } else {
    dotInfor.append(r);
    dotInfor.append(g);
    dotInfor.append(b);
  }
  dotInfor.append(dotPlacedOrder);
}

void undo() {
  // undo function
  if (dotInfor.size() > 0) {
    Boolean done = false; // for when many dots need to be deleted (entire circle)
    float set = dotInfor.get(dotInfor.size() - 1); // the dot placed order amount
    while (!done) { 
      if (dotInfor.size() > 0) { // make sure not empty
        if (dotInfor.get(dotInfor.size()-1) == set) { // if in the same dot placed order section
          //removing all information for one dot
          dotInfor.remove(dotInfor.size()-1);
          dotInfor.remove(dotInfor.size()-1);
          dotInfor.remove(dotInfor.size()-1);
          dotInfor.remove(dotInfor.size()-1);
          dotInfor.remove(dotInfor.size()-1);
          dotInfor.remove(dotInfor.size()-1);
          dotInfor.remove(dotInfor.size()-1);
        } else {
          done = true;
        }
      } else {
        done = true;
      }
    }
  }
  startTransferDelay = true;
}

// check function, doesn't work too well at the moment. It's to make sure when mouse is held, only one copy of the shape gets placed onto the canvas, so undoing gets more smooth
void check(float i) {
  int size = dotInfor.size()-1;
  if (size>0) {
    if (shape == "dot") {
      if (float(mouseX) == dotInfor.get(size-6) && float(mouseY) == dotInfor.get(size - 5) ) {
        dotWorks = false;
      } else {
        dotWorks = true;
      }
    } else if (shape == "circle") {
      int dotAmount = floor((PI * 4 * dotSize)/12);
      println(dotAmount);
      if (size > dotAmount *7) {
        if (mouseX + cos(radians(i)) * 2 * dotSize == dotInfor.get(size-6-dotAmount *7) && mouseY + sin(radians(i))*2*dotSize == dotInfor.get(size - 5-dotAmount*7)) {
          dotWorks = false;
        } else {
          dotWorks = true;
        }
      }
    } else if (shape == "triangle") {
      float thing = dotSize*3/sqrt(3);
      int dotAmount = (floor(dist(mouseX + thing, mouseY + thing, mouseX + thing, mouseY - thing) / 12 )+1) * 3 + 3;
      if (size >= dotAmount *7-1) {
        if (mouseX + 6*i == dotInfor.get(size-6-(dotAmount-1)*7) && mouseY - dotSize * 2 + 6*sqrt(3) * i == dotInfor.get(size - 5-(dotAmount-1)*7)) {
          dotWorks = false;
        } else {
          dotWorks = true;
        }
      }
    } else if (shape == "square") {
      float thing = 2 * sqrt(2) * dotSize;
      int dotAmount = (floor(dist(mouseX + thing, mouseY + thing, mouseX + thing, mouseY - thing) / 12 )+1) * 4 + 4;
      if (size >= dotAmount * 7 - 1) {
        if (mouseX + thing == dotInfor.get(size-6-(dotAmount-1)*7) && mouseY +thing - 12 * i == dotInfor.get(size - 5-(dotAmount-1)*7)) {
          dotWorks = false;
        } else {
          dotWorks = true;
        }
      }
    }
  }
}
