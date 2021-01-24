class FeetRight {
  int posX;
  int posY;
  PImage ffr;
  int currentPos;
  boolean active;

  FeetRight(int posX, int posY) {
    this.posX = posX;
    this.posY = posY;
    ffr = loadImage("rightFootFill.png");
    currentPos=-650;
  }

  void display() {
    image(ffr, posX+150, posY+currentPos);
    if (active) {
      currentPos+=10;
    }
    if (touchR==1 && 350<currentPos && currentPos<450) {
      game.score+=10;
    }
  }
  void makeActive() {
    active=true;
  }
}
