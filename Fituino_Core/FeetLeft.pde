class FeetLeft {
  int posX;
  int posY;
  PImage ffl;
  int currentPos;
  boolean active;

  FeetLeft(int posX, int posY) {
    this.posX = posX;
    this.posY = posY;
    ffl = loadImage("leftFootFill.png");
    currentPos=-650;
  }

  void display() {
    image(ffl, posX-150, posY+currentPos);
  }
  
  void update() {
    if (active) {
      currentPos+=10;
    }
    if (touchL==1 && 350<currentPos && currentPos<450) {
      game.score+=10;
    }
  }
  void makeActive() {
    active=true;
  }
}
