/*
Class for the Test page
 */

class Test {
  int posX;
  int posY;


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
    ellipse(posY,posX,100,100);
    image(footRight, posX+600, posY, 1600/1.5, 1600/1.5);
    fill(pressed);
    }
    rect(posX+70, posY+350, 100, 100);
    fill(255);
    textSize(40);
    text("R",posX+70, posY+365);
  }
  
}
