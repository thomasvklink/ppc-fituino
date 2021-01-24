class Over {
  int posX;
  int posY;
  int type;
  int timer;

  int backgroundPos = 0;

  PImage logo, background;

  Over(int posX, int posY) {
    this.posX = posX;
    this.posY = posY;
  }

  void load() {
    logo = loadImage("Logo_Fituino.png");
    background = loadImage("background-texture.jpg");
  }

  void display() {
    timer++;
    if (timer>600) {
      exit();
    }
    animatedBackground();

    //Logo
    image(logo, posX, posY-100, 1500/2, 400/2);

    //Button game over
    noStroke();

    fill(arduino);
    rect(posX-175, posY+200, 400, 80);
    fill(255);
    textSize(30);
    text("GAME OVER", posX-175, posY+210);

    //score
    fill(arduino);
    rect(posX+160, posY+200, 400, 80);
    fill(255);
    textSize(30);
    text("Score: "+game.score, posX+160, posY+210);
  }

  void animatedBackground() {
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
}
