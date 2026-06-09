/**
 * Final project of this course
 * This is a game where you can make a cake and design it with whatever you please
 * May 12 2026
 */


PFont sabrina;
String gameState = "WELCOME";
PImage bgImage;

// button layout, and their coordinates on where they are
float btnX, btnY, btnW = 500, btnH = 100;
float nextX, nextY = 50, nextW = 160, nextH = 50;
float resetX = 50, resetY = 50, resetW = 160, resetH = 50;


int currentStep = 1; //step 1: Color, step 2: style, step 3: sprinkles, step 4: finish
String frostingColor = "NONE";
String frostingDesigns = "FLAT"; // can be: flat, wavy, drip, and pip. 
int sprinkle = 0;                // 0 = none, 1 = rainbow, 2 = white, 3 = brown, 4 = green, 5 = pink, 6 = blue, 7 = orange
boolean hasCandels = false;

String introText = "Welcome to the arena, where we will be cooking hard";
float textAlpha = 255;
boolean fadingOut = true;
int fadeSpeed = 5;


//icing colors
int icingOne = #FDECEF;
int icingTwo = #36151E;
int icingThree = #FFE66D;
int icingFour = #A682FF;
int icingFive = #B1EDE8;
int icingSix = #BF4342;

void setup() {
  pixelDensity(1);
  size(1920, 1080);
  sabrina = loadFont("sabrina.vlw");
  textAlign(CENTER, CENTER);
  
  btnX = width/2 - btnW/2; 
  btnY = height/2 + 100;
  nextX = width - 210;
}

void draw() {

  if (gameState.equals("WELCOME")) {
    drawSimpleGradient();

    textFont(sabrina);
    textSize(80);
    fill(#FFFFFF);
    text("Baked", width/2, height/2 - 50);

    fill(255, 255, 255, 200); //semi transparent white button
    rect(btnX, btnY, btnW, btnH, 15);

    fill(0);
    textSize(42);
    text("START", width/2, btnY + btnH/2);
  } else if (gameState.equals("PLAY")) {
    showBakingExperience();
  }
}

// this is where the background sky texture with the horizontal loops.
void drawSimpleGradient() {

  for ( int i = 0; i < 100; i++) {
    float r = 255 - (i * 1.5);
    float g = 180 - (i * 1.3);
    float b = 200 - (i * 2.0);

    noStroke();
    fill(r, g, b);
    rect(0, i * (height/100.0), width, height/100.0);
  }  // this is going to draw 50 sprinkles for the cake
  
  randomSeed(42);
  for (int j = 0; j < 50; j++) { //j acts as integer for this.
    float r2 = random(100, 255);
    float g2 = random(100, 255);
    float b2 = random(100, 255);

    stroke(r2, g2, b2);
    strokeWeight(10); //thickness of the sprinkles

    float x1 = random(width);
    float y1 = random(height);

    //what this means is basically, this is going to make them short and tilted at random lengths and angles
    float x2 = x1 + random(10, 35); //shifts the line right by 5 to 20 pixels
    float y2 = y1 + random(10, 35);


    line(x1, y1, x2, y2);
  }
}



void showBakingExperience() {
  background(255, 230, 230);

  // fading text logic here

  if (fadingOut) {
    textAlpha -= 4;
    if (textAlpha <= 0) {
      textAlpha = 0;
     if ( currentStep == 1) introText = "click a color to frost your cake!";
      fadingOut = false;
    }
  } else {
    textAlpha += 4;
    if (textAlpha >= 255) {
      textAlpha = 255;
    }
  }
  fill(0, textAlpha);
  textSize(36);
  text(introText, width/2, 120);

  //kitchen counter
  fill(210, 180, 140);
  noStroke();
  rect(0, height - 350, width, 350);

  // all of this code is for the cake stand!!
 fill(200);
  ellipse(width/2, height - 330, 500, 60); // Stand base plate
  rect(width/2 - 35, height - 330, 70, 120); // Pillar stem
  ellipse(width/2, height - 210, 240, 35); // Foot stand base

  // The raw cake base block
 fill(245, 222, 179);
  stroke(0, 20);
  rect(width/2 - 250, height - 650, 500, 330, 0, 0, 15, 15);
  
  boolean hasColor = true;
  if (frostingColor.equals("NONE")) {
    noFill();
    noStroke();
  } else if (frostingColor.equals("PINK")) {
    fill(icingOne); //pink icing
  } else if (frostingColor.equals("BROWN")) {
    fill(icingTwo); //blue icing
  } else if (frostingColor.equals("YELLOW")) {
    fill(icingThree); //chocolate icing
  } else if (frostingColor.equals("LIGHT PURPLE")) {
    fill(icingFour);
  } else if (frostingColor.equals("CYAN")) {
    fill(icingFive);
  } else if (frostingColor.equals("RED")) {
    fill(icingSix);
  }
  
  if (hasColor) { 
    stroke(0,30);
    strokeWeight(2);
   rect(width/2 - 250, height - 640, 500, 320, 0, 0, 15, 15);
    
  if (frostingDesigns.equals("FLAT")) {
      noStroke();
      rect(width/2 - 254, height - 660, 508, 40, 12, 12, 0, 0);
    } else if (frostingDesigns.equals("WAVY")) {
      rect(width/2 - 250, height - 640, 500, 20);
      for (int x = width/2 - 220; x <= width/2 + 220; x += 60) {
        noStroke();
        ellipse(x, height - 640, 85, 50);
      }
    } else if (frostingDesigns.equals("DRIP")) {
      rect(width/2 - 254, height - 660, 508, 35, 50);
      ellipse(width/2 - 180, height - 610, 24, 50);
      ellipse(width/2 - 80, height - 590, 28, 80);
      ellipse(width/2 - 40, height - 605, 20, 60);
      ellipse(width/2 + 120, height - 595, 30, 90);
      noStroke();
    } else if (frostingDesigns.equals("PIP")) {
      rect(width/2 - 250, height - 650, 500, 20); 
      for (int x = width/2 - 225; x <= width/2 + 225; x += 50) {
        noStroke();
        ellipse(x, height - 650, 52, 52);
        triangle(x - 26, height - 650, x + 26, height - 650, x, height - 680);
        
        stroke(0, 20);
        strokeWeight(3);
        line(x - 16, height - 642, x + 16, height - 642);
      }
    }
  }
  
  //Scaled Sprinkles System
  if (currentStep >= 3 && sprinkle > 0) { 
    randomSeed(100); 
    for (int i = 0; i < 45; i++) { // Increased particle quantity for larger bounds
      float rx = random(width/2 - 220, width/2 + 210); 
      float ry = random(height - 610, height - 360); 
      
      if (sprinkle == 1) { 
        stroke(random(255), random(255), random(255));
      } else if (sprinkle == 2) {
        stroke(255); 
      } else if (sprinkle == 3) { 
        stroke(#A55B35); 
      } else if (sprinkle == 4) { 
        stroke(#30BF71);
      } else if (sprinkle == 5) { 
        stroke(#FC99FC);
      } else if (sprinkle == 6) { 
        stroke(#618DEA);
      } else if (sprinkle == 7) { 
        stroke(#EA9D61);
      }
      strokeWeight(6); // Thicker lines to stand out in Full HD
      line(rx, ry, rx + 18, ry + 18);
    }
  }
 
  if (currentStep == 1) {
    drawFrostingButtons();
  }
  if (currentStep == 2) {
    drawDesignButtons();
  }

  //Navigation Element Styling
  // MOVE ON Button
  fill(#FFE66D); 
  stroke(0, 50);
  strokeWeight(2);
  rect(nextX, nextY, nextW, nextH, 8);

  if (mouseX > nextX && mouseX <= nextX + nextW && mouseY >= nextY && mouseY <= nextY + nextH) {
    stroke(255);
    strokeWeight(3);
    noFill();
    rect(nextX, nextY, nextW, nextH, 8);
  }
  fill(0); 
  textSize(18);
  text("MOVE ON", nextX + nextW/2, nextY + nextH/2);

  // START OVER Button
  fill(#FF8A8A);
  stroke(0, 50);
  strokeWeight(2);
  rect(resetX, resetY, resetW, resetH, 8);

  if (mouseX > resetX && mouseX <= resetX + resetW && mouseY >= resetY && mouseY <= resetY + resetH) {
    stroke(255);
    strokeWeight(3);
    noFill();
    rect(resetX, resetY, resetW, resetH, 8);
  }
  fill(0);
  textSize(18);
  text("START OVER", resetX + resetW/2, resetY + resetH/2);
}

//this is where the buttons come across and i used a int list, to subject them into one icingsColors
void drawFrostingButtons() {
  int[] icingColors = { icingOne, icingTwo, icingThree, icingFour, icingFive, icingSix };

  float startx = width/2 - 340; // Centers button row symmetrically
  float buttonY = height - 120;
  float spacing = 135;
  float diameter = 90; // Larger button scale for resolution spacing

  for (int i = 0; i < 6; i++) {
    float x = startx + (i * spacing);
    float d = dist(mouseX, mouseY, x, buttonY);

    if (d < diameter/2) {
      fill(icingColors[i]);
      stroke(255);
      strokeWeight(5);
      ellipse(x, buttonY, diameter + 15, diameter + 15);
    } else {
      fill(icingColors[i]);
      stroke(0, 50);
      strokeWeight(2);
      ellipse(x, buttonY, diameter, diameter);
    }
  }
}

void drawDesignButtons() {
  String[] designs = { "FLAT", "WAVY", "DRIP", "PIP" };
  float menuX = width - 230; // Shifts panel to right margin natively
  float startY = 200;
  float btnW = 180;
  float btnH = 65;
  float spacing = 85;

  textSize(20);
  fill(0);
  text("FROSTING STYLES", menuX + btnW/2, startY - 30);

  for (int i = 0; i < designs.length; i++) {
    float y = startY + (i * spacing);

    if (frostingDesigns.equals(designs[i])) {
      fill(255);
      stroke(#A682FF);
      strokeWeight(4);
    } else if (mouseX >= menuX && mouseX <= menuX + btnW && mouseY >= y && mouseY <= y + btnH) {
      fill(240);
      stroke(0, 100);
      strokeWeight(3);
    } else {
      fill(225);
      stroke(0, 40);
      strokeWeight(1);
    }
    rect(menuX, y, btnW, btnH, 10);

    fill(0);
    textSize(18);
    text(designs[i], menuX + btnW/2, y + btnH/2);
  }
}

void mousePressed() {
  if (gameState.equals("WELCOME")) {
    if (mouseX >= btnX && mouseX <= btnX + btnW && mouseY >= btnY && mouseY <= btnY + btnH) {
      gameState = "PLAY";
    }
  } 
  else if (gameState.equals("PLAY")) {
    
    // START OVER button click tracking
    if (mouseX >= resetX && mouseX <= resetX + resetW && mouseY >= resetY && mouseY <= resetY + resetH) { 
      currentStep = 1; 
      frostingColor = "NONE"; 
      frostingDesigns = "FLAT"; 
      sprinkle = 0; 
      introText = "click a color to frost your cake!";
      fadingOut = true; 
      return; 
    } 
    
    // MOVE ON button click tracking
    if (mouseX >= nextX && mouseX <= nextX + nextW && mouseY >= nextY && mouseY <= nextY + nextH) {
      currentStep++; 
      fadingOut = true;
      
      if (currentStep == 2) { 
        introText = "Now choose a frosting style on the right"; 
      } else if (currentStep == 3) { 
        sprinkle = 1; 
        introText = "Use your keys 1-7 to select custom sprinkle styles!"; 
      } else if (currentStep >= 4) { 
        introText = "BRO YOU ATE THAT UPP!!"; 
      }
      return;
    }
    
    // Color Selector Clicks (Scaled bound ranges evaluated)
    if (currentStep == 1) { 
      float startx = width/2 - 340;
      float buttonY = height - 120;
      float spacing = 135;
      float diameter = 90;

      for (int i = 0; i < 6; i++) {
        float x = startx + (i * spacing);
        float d = dist(mouseX, mouseY, x, buttonY);

        if (d < diameter/2) {
          if (i == 0) frostingColor = "PINK";
          if (i == 1) frostingColor = "BROWN";
          if (i == 2) frostingColor = "YELLOW";
          if (i == 3) frostingColor = "LIGHT PURPLE";
          if (i == 4) frostingColor = "CYAN";
          if (i == 5) frostingColor = "RED";
        }
      }
    }
    
    // Frosting Menu Variant Selection Processing
    if (currentStep == 2) { 
      float menuX = width - 230;
      float startY = 200;
      float btnW = 180;
      float btnH = 65;
      float styleSpacing = 85;

      for (int i = 0; i < 4; i++) { 
        float y = startY + (i * styleSpacing); 
        if (mouseX >= menuX && mouseX <= menuX + btnW && mouseY >= y && mouseY <= y + btnH) {
          if (i == 0) frostingDesigns = "FLAT"; 
          if (i == 1) frostingDesigns = "WAVY";
          if (i == 2) frostingDesigns = "DRIP";
          if (i == 3) frostingDesigns = "PIP";
        } 
      }
    }    
  }
}

void keyPressed() { 
  if (currentStep >= 3) { 
    if (key == '1') { 
      sprinkle = 1; //rainbow
    } else if (key == '2') { 
      sprinkle = 2; //white
    } else if (key == '3') { 
      sprinkle = 3; //brown 
    } else if (key == '4') { 
      sprinkle = 4; //green
    } else if (key == '5') { 
      sprinkle = 5; //pink
    } else if (key == '6') { 
      sprinkle = 6; //blue
    } else if (key == '7') { 
      sprinkle = 7; //orange
    } 
  }
}
