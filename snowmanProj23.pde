/* ***********************************************************************
* Daniel Tran
* Snowman - Assignment 1
* Computer Science 10 Block 2
* 10/14/2020

* This program is my own work - Digital Signature DT */
/* @pjs preload="gradient.png"; */
Snowman s; // player

Mountain m;

boolean[] keys;
int start = 0; //start game
boolean setup = false;

int tseconds = 0; //tree timer
int mseconds = 0; //mountain timer
int points = 0; //points
int highsize = 0; //highest size


PImage background;

// OBJECTS IN GAME
ArrayList<Snowball> snowballs = new ArrayList<Snowball>(); 
ArrayList<Tree> trees = new ArrayList<Tree>(); 
ArrayList<House> houses = new ArrayList<House>(); 
ArrayList<Mountain> mountains = new ArrayList<Mountain>(); 
ArrayList<Snowflake> snowflakes = new ArrayList<Snowflake>(); 



void setup() {
    size(1500, 800);
    s = new Snowman(100, 10);

    mountains.add(new Mountain(-100, height, 5, 800, 500, 1));
    mountains.add(new Mountain(500, height, 5, 1000, 600, 2));
    mountains.add(new Mountain(1400, height, 5, 1000, 500, 3));


    keys = new boolean[4];

    background = loadImage("gradient.png");
    image(background, 0, 0);
}

void draw() {

    

    noStroke();
    
    if (start == 1) {
        
        image(background, 0, 0);
        
        // SECOND COUNTER AND GENERATION
        if (!setup) {
            setup = true;
            tseconds = millis()/1000;
            mseconds = millis()/1000;
        }
        
        int secs = millis()/1000;

        if (secs > tseconds) {
            tseconds = secs;
            tseconds += random(2, 3);
            
            for (int i = 0; i < floor(((s.r-20 < 0) ? 0 : s.r-20)/20)+1; i++) {
                trees.add(new Tree(width+ceil(random(100, 1000)), height, random(5, 15), random(30, 50)));
            }

            if (random(1) > 0.5) {
                houses.add(new House(width+ceil(random(100, 1000)), height, random(5, 10), random(30, 50)));
            }

            if (random(1) > 0.8) {
                trees.add(new Tree(width+ceil(random(100, 1000)), height, random(5, 15), random(30, 50)));
                trees.add(new Tree(width+ceil(random(100, 1000)), height, random(5, 15), random(30, 50)));
                trees.add(new Tree(width+ceil(random(100, 1000)), height, random(5, 15), random(30, 50)));
                trees.add(new Tree(width+ceil(random(100, 1000)), height, random(5, 15), random(30, 50)));
            }

            snowflakes.add(new Snowflake(random(width), 1, 10));
            snowflakes.add(new Snowflake(random(width), 1, 10));
            snowflakes.add(new Snowflake(random(width), 1, 10));
        }

        if (secs > mseconds) {
            mseconds = secs;
            mseconds += random(2, 3);


            for (int i = 0; i < 2; i ++) {

                int l = ceil(random(1, 3));
                float w;

                if (l == 3) {
                    w = random(80, width*0.6);
                    mountains.add(new Mountain(width+(int)random(50), height, 5, w, random(100, w+100), 3));
                } else if (l == 2) {
                    w = random(80, width*0.7);
                    mountains.add(new Mountain(width+(int)random(50), height, 4, w, random(100, w+100), 2));
                }

                w = random(100, width*0.8);
                mountains.add(new Mountain(width+(int)random(50), height, 3, w, random(100, w+100), 1));
            }
        }


        // FORCES

        PVector force = new PVector(0, 0);
        PVector gravity = new PVector(0, 1);
        PVector friction = new PVector(s.vel.x, s.vel.y);

        friction.normalize();
        friction.mult(-0.1);

        // KEY DETECTION AND FORCE APPLICATION

        if (keyPressed && keys[1]) {
            force.add(0, 0.5);
        }

        if (keyPressed && keys[0]) {
            force.add(-0.3, 0.0);
        }

        if (keyPressed && keys[2]) {
            force.add(0.3, 0.0);
        }

        if (keyPressed && keys[3]) {
            if (s.loc.y + s.r + 1 >= height) {
                s.vel.add(new PVector(0, -25));
            }
            force.add(0.0, -0.4);
        }
        s.applyForce(friction);
        s.applyForce(gravity);
        s.applyForce(force);



        // OBJECT UPDATING AND DRAWING

        //sun

        fill(252, 230, 109);

        push();
        translate(0, height);
        rotate((TWO_PI/20000)*-2000);
        ellipse(1000, 0, 200, 200);
        pop();


        for (int j = 1; j <= 3; j++) {
            for (int i = mountains.size()-1; i >= 0; i--) {
                if (mountains.get(i).level == j) {
                    mountains.get(i).update();
                    mountains.get(i).display();


                    if (mountains.get(i).end()) {
                        mountains.remove(i);
                    }
                }
            }
        }

        fill(#65B0E8);
        rect(0, height-30, width, 30);

        s.update();
        s.edges();
        s.display();


        for (int i = snowballs.size()-1; i >= 0; i--) {
            boolean remove = false;
            snowballs.get(i).applyForce(gravity);
            snowballs.get(i).update();
            snowballs.get(i).display();

            for (int j = trees.size()-1; j >= 0; j--) {
                if (snowballs.get(i).touching(trees.get(j))) {
                    trees.remove(j);
                    remove = true;
                }
            }

            if (snowballs.get(i).touchingEdges()) {
                remove = true;
            }

            if (remove) {
                snowballs.remove(i);
            }
        }

        for (int i = trees.size()-1; i >= 0; i--) {
            trees.get(i).update();
            trees.get(i).display();

            if (s.touching(trees.get(i))) {
                s.r -= 0.1;
            }

            if (trees.get(i).end()) {
                trees.remove(i);

                points++;
                s.r += 2;
            }
        }

        for (int i = houses.size()-1; i >= 0; i--) {
            houses.get(i).update();
            houses.get(i).display();


            if (s.touching(houses.get(i))) {
                s.r -= 0.1;
            }


            if (houses.get(i).end()) {
                houses.remove(i);

                points++;
                s.r += 2;
            }
        }

        for (int i = snowflakes.size()-1; i >= 0; i--) {
            snowflakes.get(i).update();
            snowflakes.get(i).display();


            if (snowflakes.get(i).end()) {
                snowflakes.remove(i);
            } else if (s.touching(snowflakes.get(i))) {
                snowflakes.remove(i);
                s.r += 5;
            }
        }
    
        fill(255);
        textSize(50);
        textAlign(LEFT);
        
        if (s.r > highsize) {
            highsize = s.r;
        }
        
        
        
        text("POINTS:" + points, 50, 100);
        text("SIZE:" + s.r, 50, 150);
        text("BIGGEST SIZE:" + highsize, 50, 200);
        
        if (s.r <= 0) {
            start = 2;
        }
        
    } else if (start == 0) {
        
        fill(252, 230, 109);

        push();
        translate(0, height);
        rotate((TWO_PI/20000)*-2000);
        ellipse(1000, 0, 200, 200);
        pop();
        
        for (int j = 1; j <= 3; j++) {
            for (int i = mountains.size()-1; i >= 0; i--) {
                if (mountains.get(i).level == j) {
                    mountains.get(i).display();
                }
            }
        }
        
        fill(255);
        textSize(60);
        textAlign(CENTER);
        text("CLICK ANYWHERE TO BEGIN", width/2, height/2-10);
        textSize(40);
        text("WASD to move | Click to shoot", width/2, height/2+50);
        text("Don't let your size reach 0", width/2, height/2+100);
        text("Hitting trees and cabins, and shooting decrease size", width/2, height/2+150);
        text("Catching snowflakes, and trees reaching the left increase size", width/2, height/2+200);
    
    } else if (start == 2) {
        textAlign(CENTER);
        textSize(60);
        text("GAME OVER", width/2, height/2-10);
        textSize(40);
        text("Your size reached 0", width/2, height/2+50);
        
    }
} 
void mousePressed() {
    
    if (start == 1) {
        Snowball snow = new Snowball(s.loc.x, s.loc.y + -2*s.r);
        snowballs.add(snow);
    
        PVector force = new PVector(mouseX, mouseY).sub(new PVector(s.loc.x, s.loc.y)).limit(35);
    
        snow.applyForce(force);
        s.applyForce(force.mult(-0.10));
    
        s.r -= 2;
    } else if (start == 2) {
        image(background, 0, 0);
        s = new Snowman(100, 10);
        trees.clear();
        houses.clear();
        points = 0;
        highsize = 0;
        start = 0;
    } else if (start == 0) {
        start = 1;
    }

}


void keyPressed() {
    if (keyCode == UP || key == 'w' || key == ' ') {
        keys[3] = true;
    }

    if (keyCode == LEFT || key == 'a') {
        keys[0] = true;
    }

    if (keyCode == DOWN || key == 's') {
        keys[1] = true;
    }

    if (keyCode == RIGHT || key == 'd') {
        keys[2] = true;
    }
}

void keyReleased() {
    if (keyCode == LEFT || key == 'a') {
        keys[0] = false;
    }

    if (keyCode == DOWN || key == 's') {
        keys[1] = false;
    }

    if (keyCode == RIGHT || key == 'd') {
        keys[2] = false;
    }

    if (keyCode == UP || key == 'w' || key == ' ') {
        keys[3] = false;
    }
}
class House{
    
    
    PVector loc;
    float speed;
    float size;
    
    House(int x, int y, float s, float si) {
        loc = new PVector(x, y);
        speed = s;
        size = si;
        
    }
    
    void display() {
        
        push();
        translate(loc.x, loc.y);
        
        fill(112, 80, 55);
        rect(0-size, 0-size, size, size);
        triangle(0-(1.25*size), 0-(size*0.9), 0-(0.5*size), 0-(1.5*size), 0.25*size, 0-(size*0.9));
        
        pop();
        
        
    }
    
    void update() {
        loc.x -= speed;
    }
    
    boolean end() {
        if (loc.x < 0) {
            return true;
        } else {
            return false;
        }
    }
    
}
class Snowman {

    // Vectors for position, velocity and acceleration

    PVector loc;
    PVector vel;
    PVector acc;

    int r;

    Snowman(int x, int y) {
        loc = new PVector(x, y);
        vel = new PVector(0, 0);
        acc = new PVector(0, 0);

        r = 50;
    }

    void applyForce(PVector force) {
        acc.add(force);
    }

    void update() {
        vel.add(acc);
        loc.add(vel);

        acc.setMag(0);
    }

    void display() {
        noStroke();
        
        // body
        fill(255);
        ellipse(loc.x, loc.y, 2*r, 2*r);
        ellipse(loc.x, loc.y-(2*r)+r/2, (2*r)/1.2, (2*r)/1.2);
        ellipse(loc.x, (loc.y-(4*r))+1.3*r, (2*r)/1.5, (2*r)/1.5);
        
        
        //hat
        fill(30);
        rect(loc.x - r*0.75, loc.y - (2.7*r + r*0.75), r*1.5, r/3);
        rect(loc.x - r*0.4, loc.y - (2.7*r + r*1.75), r*0.8, r*1.1);
        
        fill(207, 116, 116);
        rect(loc.x - r*0.4, loc.y - (2.7*r + r*1), r*0.8, r/4);
        
        //eyes
        fill(30);
        ellipse(loc.x - r/3, loc.y - (2.7*r + r*0.1), r/5, r/5);
        ellipse(loc.x + r/3, loc.y - (2.7*r + r*0.1), r/5, r/5);
        
        //nose
        fill(249, 178, 56);
        triangle(loc.x, loc.y - (2.7*r + r/8), loc.x, loc.y - (2.7*r - r/8), loc.x + r*0.6, loc.y - (2.7*r));
        
        //bowtie - Represents me because sometimes I like to feel fancy and wear ties. ;)
        fill(207, 116, 116);
        triangle(loc.x, loc.y - (2*r), loc.x + r/3, loc.y - (2.2*r), loc.x + r/3, loc.y - (1.8*r) );
        triangle(loc.x, loc.y - (2*r), loc.x - r/3, loc.y - (2.2*r), loc.x - r/3, loc.y - (1.8*r) );
    }

    void edges() {
        if (loc.x - r < 0) {
            vel.x *= -0.5;
            loc.x = 0 + r;
        }

        if (loc.x + r > width) {
            vel.x *= -0.5;
            loc.x = width - r;
        }

        if (loc.y - r < 0) {
            vel.y *= -0.5;
            loc.y = 0 + r;
        }

        if (loc.y + r > height) {
            vel.y *= 0;
            loc.y = height - r;
        }
    }

    boolean touching(Tree t) {
        //println(dist(loc.x, loc.y, t.loc.x + t.size/2, 4.25*t.size));

        /*
        strokeWeight(10);
         
         fill(0, 0, 255);
         ellipse(loc.x, loc.y, 10, 10);
         
         fill(255, 0, 0);
         ellipse(t.loc.x - t.size/2, height - 4.25*t.size, 10, 10);
         
         ellipse(t.loc.x - t.size/2, height - 3*t.size, 10, 10);
         
         ellipse(t.loc.x - t.size/2, height - 1.5*t.size, 10, 10);
         */


        if (dist(loc.x, loc.y, t.loc.x - t.size/2, height - 4.25*t.size) < r+t.size || dist(loc.x, loc.y, t.loc.x - t.size/2, height - 3*t.size) < r+t.size || dist(loc.x, loc.y, t.loc.x - t.size/2, height - 1.5*t.size) < r+t.size) {
            return true;
        } else {
            return false;
        }
    }

    boolean touching(Snowflake s) {

        /*
        fill(255, 0, 0);
         ellipse(loc.x, loc.y, 10, 10);
         ellipse(loc.x, loc.y-(1.5*r), 10, 10);
         ellipse(loc.x, loc.y-(2.7*r), 10, 10);
         */

        if (dist(loc.x, loc.y, s.loc.x, s.loc.y) < r || dist(loc.x, loc.y-(1.5*r), s.loc.x, s.loc.y) < r || dist(loc.x, loc.y-(2.7*r), s.loc.x, s.loc.y) < r) {
            return true;
        } else {
            return false;
        }
    }
   
   
    boolean touching(House h) {
        if (dist(loc.x, loc.y, h.loc.x - (h.size/2), height - (h.size/2)) < r + h.size || dist(loc.x, loc.y, h.loc.x - (h.size/2), height - h.size) < r + h.size) {
            return true;
        } else {
            return false;
        }
    }
}
class Mountain {
    
    PVector loc;
    float speed;
    float base;
    float tall;
    int level; //background or foreground mountains
    
    Mountain(int x, int y, float s, float b, float h, int l) {
        loc = new PVector(x, y);
        speed = s;
        
        base = b;
        tall = h;
        
        level = l;
    }
    
    void display() {
        switch(level) {
            
            case 1:
                fill(#AFD8F7);
                break;
            case 2:
                fill(#7DB9E5);
                break;
            case 3:
                fill(#65B0E8);
                break;
            
        }
        triangle(loc.x, loc.y, loc.x + (base/2), height-tall, loc.x + base, loc.y);
        
    }
    
    
    void update() {
        loc.x -= speed;
    }
    
    boolean end() {
        if (loc.x + base < 0) {
            return true;
        } else {
            return false;
        }
    }
    
}
class Snowball {
    
    PVector loc;
    PVector vel;
    PVector acc;
    int r;
    
    Snowball(float x, float y) {
        
        loc = new PVector(x, y);
        vel = new PVector(0, 0);
        acc = new PVector(0, 0);
        
        r = 20;
    }
    
    void applyForce(PVector force) {
        acc.add(force);
    }
    
    void update() {
        vel.add(acc);
        loc.add(vel);
        
        acc.setMag(0);
    }
    
    void display() {
        noStroke();
        fill(255);
        ellipse(loc.x, loc.y, 2*r, 2*r);
    }
    
    boolean touchingEdges() {
        if (loc.x - r < 0 || loc.x + r > width || loc.y - r < 0 || loc.y + r > height) {
            return true;
        } else {
            return false;
        }
            
    }
    
    boolean touching(Tree t) {


        if (dist(loc.x, loc.y, t.loc.x - t.size/2, height - 4.25*t.size) < r+t.size || dist(loc.x, loc.y, t.loc.x - t.size/2, height - 3*t.size) < r+t.size || dist(loc.x, loc.y, t.loc.x - t.size/2, height - 1.5*t.size) < r+t.size) {
            return true;
        } else {
            return false;
        }
    }
   
   
    boolean touching(House h) {
        if (dist(loc.x, loc.y, h.loc.x - (h.size/2), height - (h.size/2)) < r + h.size || dist(loc.x, loc.y, h.loc.x - (h.size/2), height - h.size) < r + h.size) {
            return true;
        } else {
            return false;
        }
    }
    
}
class Snowflake {
    
    PVector loc;
    PVector vel;
    float size;
    
    Snowflake(float x, float y, float s) {
        loc = new PVector(x, y);
        vel = new PVector(random(-5,5), random(2, 5));
        size = s;
        
    }
    
    void update() {
        loc.add(vel);
    }
    
    
    void display() {
        fill(255);
        ellipse(loc.x, loc.y, size, size);
    }
    
    boolean end() {
        if (loc.x - size < 0 || loc.x + size > width || loc.y + size > height) {
            return true;
        } else {
            return false;
        }
            
    }
    
}
class Tree{
    
    
    PVector loc;
    float speed;
    float size;
    
    Tree(int x, int y, float s, float si) {
        loc = new PVector(x, y);
        speed = s;
        size = si;
        
    }
    
    void display() {
        
        push();
        translate(loc.x, loc.y);
        
        fill(110, 83, 65);
        rect(0-size, 0-(2*size), size, 2*size);
        
        fill(81, 115, 85);
        triangle(0-(1.75*size), 0-(1.5*size), 0-(size/2), 0-(4.5*size), size*0.75, 0-(1.5*size));
        
        triangle(0-(1.5*size), 0-(1.5*size)-(1.5*size), 0-(size/2), 0-(3.5*size)-(1.5*size), size*0.5, 0-(1.5*size)-(1.5*size));
        
        triangle(0-(1.20*size), 0-(1.5*size)-(2.75*size), 0-(size/2), 0-(3.5*size)-(2*size), size*0.20, 0-(1.5*size)-(2.75*size));
        
        pop();
        
        
    }
    
    void update() {
        loc.x -= speed;
    }
    
    boolean end() {
        if (loc.x < 0) {
            return true;
        } else {
            return false;
        }
    }
    
}
