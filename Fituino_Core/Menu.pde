/*
Class for the program menus
-- We handle the all the GUI related operation of the program
-- aswell as
 */

class Menu {
  //Variables for position and type of menu
  int posX;
  int posY;
  int type;

  //Booleans for mouse hover checks and settings menu
  boolean overStart;
  boolean overTest;
  boolean overSetting;
  boolean settings;
  boolean overMusic;
  boolean overSound;

  int backgroundPos = 0;

  String motd;  //String to store the message of the day

  PImage logo, background, settingIcon, musicIcon, soundIcon; //Initializing images
  SoundFile menu; //Initializing music


  Menu(int posX, int posY, int type) {
    this.posX = posX;
    this.posY = posY;
    this.type = type;
  }

  void load() {
    logo = loadImage("Logo_Fituino.png"); //Load logo image.
    background = loadImage("background-texture.jpg"); //Load background image.
    settingIcon = loadImage("settings-icon.png"); //Load settings icon.
    soundIcon = loadImage("sound-icon.png"); //Load settings icon.
    musicIcon = loadImage("music-icon.png");
    menu = new SoundFile(Fituino_Core.this, "soundscrate-brand-new-start.mp3"); //Load sound file for menu music.
    String[] motdInput = loadStrings("motd.txt"); //Loading MOTD's (Message of the day) from a text file.
    motd = motdInput[int(random(0, motdInput.length))]; //Select a random MOTD each time the program is loaded.
  }

  void display() {
    switch(type) { //Different menu's to display
    case 1: //Main menu
      mainMenu();
      music();
      break;
    case 2: //Pause menu
      pauseMenu();  
      break;
    }
  }

  void update(int mousePosX, int mousePosY) { //Checks if mouse is over a button
    
    //Check for "Start training" button
    if ((mousePosX > posX-375) && (mousePosX < posX+25) && (mousePosY > posY+200-40) && (mousePosY < posY+200+40)) { 
      overStart = true;
    } else { 
      overStart = false;
    }

    //Check for "Test" button
    if ((mousePosX > posX+60) && (mousePosX < posX+260) && (mousePosY > posY+200-40) && (mousePosY < posY+200+40)) { 
      overTest = true;
    } else { 
      overTest = false;
    }
    
    //Check for "Settings" button
    if ((mousePosX > posX+335-40) && (mousePosX < posX+335+40) && (mousePosY > posY+200-40) && (mousePosY < posY+200+40)) {
      overSetting = true;
    } else { 
      overSetting = false;
    }
    
      //Check for "Music" button
      if ((mousePosX > posX+335-40) && (mousePosX < posX+335+40) && (mousePosY > posY+300-40) && (mousePosY < posY+300+40)) {
        overMusic = true;
      } else { 
        overMusic = false;
      }
      
      //Check for "Sound" button
      if ((mousePosX > posX+335-40) && (mousePosX < posX+335+40) && (mousePosY > posY+400-40) && (mousePosY < posY+400+40)) {
        overSound = true;
      } else { 
        overSound = false;
      }
  }

  void clicked() { //Handles the click actions of the buttons
    if (overStart) { //If cursor is over start button and clicks go to the game screen
      screen = 2;
    }

    if (overTest) { //If cursor is over test button and clicks go to the test screen
      screen = 3;
    }

    if (overSetting) { //If the cursor is over settings toggle and clicks toggle the settings menu
      if (!settings){
        settings = true;
      } else {
        settings = false;
      }
    }
      
      if(overMusic){ //Toggles music boolean
        if(!music){
          music = true;
          saveSetting(); //Runs method on main tab to save the selected setting into a text file
        } else {
          music = false;
          saveSetting();
        }
      }
      
      if(overSound){ //Toggles sound boolean
        if(!sound){
          sound = true;
          saveSetting();  //Runs method on main tab to save the selected setting into a text file
        } else {
          sound = false;
          saveSetting();
        }
      }
      
      
  }

  void mainMenu() {
    animatedBackground(); //Background methods, defined later. Is also used in different classes.

    //Logo
    image(logo, posX, posY-100, 1500/2, 400/2);

    //Tagline
    fill(100);
    text(motd, posX, posY+90); //Display a random MOTD (handeled in line 31-32).

    //Button "Start training"
    noStroke();
    if (!overStart) { //Hover effect
      fill(0, 129, 132);
    } else {
      fill(pressed);
    }
    rect(posX-175, posY+200, 400, 80);
    fill(255);
    textSize(30);
    text("Start training", posX-175, posY+210);

    //Button "Test"
    if (!overTest) { //Hover effect
      fill(arduino);
    } else {
      fill(pressed);
    }
    rect(posX+160, posY+200, 200, 80);
    fill(255);
    textSize(30);
    text("Test", posX+160, posY+210);

    //Button "Settings" displayed as icon.
    if (!overSetting) { //Hover effect
      fill(arduino);
    } else {
      fill(pressed);
    }
    rect(posX+335, posY+200, 80, 80);
    image(settingIcon, posX+335, posY+200, 50, 50);
    
    if(settings){ //Opens settings menu
      
      //Toggle music button
      if (music){
        fill(20,160,41); //Green background
      } else {
        fill(214,30,30); //Red background
      }
      rect(posX+335, posY+300, 80, 80);
      image(musicIcon, posX+335, posY+300, 50, 50);
      
      //Toggle sound button
      if (sound){
        fill(20,160,41); //Green background
      } else {
        fill(214,30,30); //Red background
      }
      rect(posX+335, posY+400, 80, 80);
      image(soundIcon, posX+335, posY+400, 50, 50);
      
    }
    
  }

  void pauseMenu() {
    //TO ADD IN FUTURE VERSION
  }


  void music() { //Music handeler
    if (music) {
      switch(type) {
      case 1: //Main menu music
        if (!menu.isPlaying()) { //If the music isn't already playing, start it
          menu.play();
          menu.amp(volume); //Change the volume according to global setting.
        } 
        break;
      case 2: //Pauze menu music
      //TO ADD IN FUTURE VERSION
        break;
      }
    } else {
      menu.stop(); //Stop the music currently playing
    }
  }

  void animatedBackground() { //Looping background animation
    backgroundPos++; //Variable for position altering
    if (backgroundPos > 600) { //Reset position variable after 600 pixels of diagonal movement
      backgroundPos = 0;
    }
    for (int i = 0; i<5; i++) { //Create a grid of 5x4 of seamless texture images.
      for (int t = 0; t<4; t++) {
        image(background, -600+(600*i)+backgroundPos, -600+(600*t)+backgroundPos, 600, 600); //Moves images according to variable.
      }
    }
  }
}
