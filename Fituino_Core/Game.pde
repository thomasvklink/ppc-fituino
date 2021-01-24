/*
Class for the game menus
 */

class Game {
  int posX;
  int posY;
  int type;
  int score;
  PImage box, background, fl, fr;
  int backgroundPos = 0;
  boolean rave = true;
  SoundFile raveSound;
  int time = 0;
  int startTime;
  boolean start;
  int yLeft, yRight;
  Feet[] feet;


  Game(int posX, int posY) {
    this.posX = posX;
    this.posY = posY;
  }

  void load() {
    box = loadImage("gameBox.png");
    background = loadImage("background-texture.jpg");
    raveSound = new SoundFile(Fituino_Core.this, "crabRave.wav");
    fr = loadImage("rightFoot.png");
    fl = loadImage("leftFoot.png");
    feet = new Feet[60];
  }
  void display() {
    // background and
    animatedBackground();
    image(box, posX, posY);
    image(fl, posX-150, posY+400);
    image(fr, posX+150, posY+400); 

    feet();

    textSize(40);
    fill(0);
    text("Score: "+score, posX-800, posY+500);

    if (!start) {
      start=true;
      startTime=millis();
    }

    //time show and set
    text("Time: "+time, posX+750, posY+500);
    time = int((millis() - startTime)/1000);

    if (rave) {

      image(crab, posX-700, posY-300);
      image(crab, posX+700, posY-300);

      main.menu.stop();
      if (!raveSound.isPlaying()) {
        raveSound.play();
      }
    }
  }
  void animatedBackground() { //animated background from menu class
    backgroundPos++;
    if (backgroundPos > 600) {
      backgroundPos = 0;
    }
    for (int i = 0; i<5; i++) {
      for (int t = 0; t<4; t++) {
        image(background, -600+(600*i)+backgroundPos, -600+(600*t)+backgroundPos, 600, 600);
      }
    }
  }

  void setRave(boolean choice) { //setter for rave mode
    rave = choice;
  }
  void feet() {

  }
}
