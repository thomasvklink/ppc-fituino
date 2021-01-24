
class Feet {
  int posX;
  int posY;
  PImage ffr, ffl;

  Feet() {
    ffr = loadImage("rightFootFill.png");
    ffl = loadImage("leftFootFill.png");
  }

  void display() {
    image(ffl, posX-150, posY-current);
    image(ffr, posX+150, posY+400);
  }
}
