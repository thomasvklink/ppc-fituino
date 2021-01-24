/*
Class for the game menus
 */

class Game {
  int posX;
  int posY;
  int type;
  PImage box, background;
  int backgroundPos = 0;
  boolean rave = true;
  SoundFile raveSound;


  Game(int posX, int posY) {
    this.posX = posX;
    this.posY = posY;
  }

  void load() {
    box = loadImage("gameBox.png");
    background = loadImage("background-texture.jpg");
    raveSound = new SoundFile(Fituino_Core.this, "crabRave.wav");
  }

  void display() {
    // Always displayed
    animatedBackground();
    image(box, posX, posY);

    if (rave) {
      image(crab, posX+20, posY+20);
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
}
