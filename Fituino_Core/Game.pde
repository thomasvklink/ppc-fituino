/*
Class for the game

(extra) Assets:
Crab sound from Eoin O'Brien
Crab gif from Tenor
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
  int lastTime;
  int feetSpawn;
  boolean start;
  int yLeft, yRight;
  FeetRight[] feetR;
  FeetLeft[] feetL;
  boolean left =true;
  int feetAmount=120;
  int touchTimer;

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
    feetR = new FeetRight[feetAmount];
    for (int i = 0; i < feetAmount; i++) {
      feetR[i] = new FeetRight(posX, posY);
    }
    feetL = new FeetLeft[feetAmount];
    for (int i = 0; i < feetAmount; i++) {
      feetL[i] = new FeetLeft(posX, posY);
    }
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

    if (touchL==1 || touchR==1) {
      touchTimer++;
    } else {
      touchTimer=0;
    }

    if (touchTimer>240 || time>55) {
      screen=4;
    }
    //time show and set
    text("Time: "+time, posX+750, posY+500);
    time = int((millis() - startTime)/1000);

    if (rave) {

      image(crab, posX-700, posY-300);
      image(crab, posX+700, posY-300);

      main.menu.stop();
      if (music){
      if (!raveSound.isPlaying()) {
        raveSound.play();
      }
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
    for (FeetRight feet : feetR) {
      feet.display();
    }
    for (FeetLeft feet : feetL) {
      feet.display();
    }
    if (int(random(0, 75))==1) {
      if (left) {
        feetL[feetSpawn].makeActive();
        left=false;
      } else {
        feetR[feetSpawn].makeActive();
        left=true;
      }

      feetSpawn++;
    }
  }
}
