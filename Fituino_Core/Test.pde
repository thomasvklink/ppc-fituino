/*
Class for the Test page
-- Displays an overview of the Fituino Interface and provides feedback to
-- check if your arduino has been properly set up.
 */

class Test {
  int posX;
  int posY;
  boolean overBack;

  PImage breadboard, footLeft, footRight; 
  Menu background;
  
  Test(int posX, int posY) {
    this.posX = posX;
    this.posY = posY;
    background = new Menu(posX, posY, 1);
  }

  void load() {
    background.load();
    breadboard = loadImage("Fituino_bb.png");
    footLeft = loadImage("foot-left.png");
    footRight = loadImage("foot-right.png");
  }

  void display() {
    background.animatedBackground();
    image(breadboard, posX, posY-100, 950/2, 1570/2);
    
    noStroke();
    
    if(touchL == 0){
    fill(arduino);
    } else {
    image(footLeft, posX-600, posY, 1600/1.5, 1600/1.5);
    fill(pressed);
    }
    rect(posX-70, posY+350, 100, 100);
    fill(255);
    textSize(40);
    text("L",posX-70, posY+365);
    
    if(touchR == 0){
    fill(arduino);
    } else {
    image(footRight, posX+600, posY, 1600/1.5, 1600/1.5);
    fill(pressed);
    }
    rect(posX+70, posY+350, 100, 100);
    fill(255);
    textSize(40);
    text("R",posX+70, posY+365);
    
    if(!overBack){
      fill(200);
    } else {
      fill(150);
    }
    rect(posX, posY+460, 470, 50);
    fill(255);
    textSize(25);
    text("Back to main menu", posX, posY+470);
  }
  
  void update(int mousePosX, int mousePosY) {

    if ((mousePosX > posX-235) && (mousePosX < posX+235) && (mousePosY > posY+470-25) && (mousePosY < posY+470+25)) {
      overBack = true;
    } else { overBack = false;}
    println(overBack);
  }
  
  void clicked(){
    if(overBack){
      screen = 1;
    }
   }
  
}
