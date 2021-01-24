/*
Class for the game menus
 */

class Menu {
  int posX;
  int posY;
  int type;
  
  int mousePosX;
  int mousePosY;
  boolean overStart;
  boolean overTest;
  
  int backgroundPos = 0;
  
  String motd;

  PImage logo, background;
  SoundFile menu;


  Menu(int posX, int posY, int type) {
    this.posX = posX;
    this.posY = posY;
    this.type = type;
  }

  void load() {
    logo = loadImage("Logo_Fituino.png");
    background = loadImage("background-texture.jpg");
    menu = new SoundFile(Fituino_Core.this, "soundscrate-brand-new-start.mp3");
    String[] motdInput = loadStrings("motd.txt"); //Loading MOTD's (Message of the day) from a text file.
    motd = motdInput[int(random(0, motdInput.length))]; //Select a random MOTD each time the program is loaded.
  }

  void display() {
    switch(type) {
    case 1:
      mainMenu();
      music();
      break;
    case 2:
      pauseMenu();
      break;
    }
  }
  
  void update(int mousePosX, int mousePosY){
    //this.mousePosX = mousePosX;
    //this.mousePosY = mousePosY;
    
    if ((mousePosX > posX-375) && (mousePosX < posX+25) && (mousePosY > posY+200-40) && (mousePosY < posY+200+40)){
      overStart = true;
    } else { overStart = false;}
    
    if ((mousePosX > posX+60) && (mousePosX < posX+260) && (mousePosY > posY+200-40) && (mousePosY < posY+200+40)){
      overTest = true;
    } else { overTest = false;}
    println(overTest);
  }
  
  void clicked(){
    if (overStart){
      screen = 2;
    }
    
    if (overTest){
      screen = 3;
    }
  }

  void mainMenu() {
    animatedBackground();

    //Logo
    image(logo, posX, posY-100, 1500/2, 400/2);

    //Tagline
    fill(100);
    text(motd, posX, posY+90);

    //Button start
    noStroke();
    if (!overStart){
      fill(arduino);
    } else {
      fill(pressed);
    }
    rect(posX-175, posY+200, 400, 80);
    fill(255);
    textSize(30);
    text("Start training", posX-175, posY+210);

    //Button practise
    noStroke();
    if (!overTest){
      fill(arduino);
    } else {
      fill(pressed);
    }
    rect(posX+160, posY+200, 200, 80);
    fill(255);
    textSize(30);
    text("Test", posX+160, posY+210);

    //Button effects
    noStroke();
    fill(0, 129, 132);
    rect(posX+335, posY+200, 80, 80);
  }

  void pauseMenu() {
    
  }

  void music() {
    if (music) {
      switch(type) {
      case 1:
        if (!menu.isPlaying()) {
           menu.play();
           menu.amp(volume);
        }
        break;
      case 2:

        break;
      }
    }
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
