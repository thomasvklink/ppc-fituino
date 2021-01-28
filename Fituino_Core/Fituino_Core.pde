/*
Fituino, an Arduino interfaced fitness game in Processing
 January 2021
 by Thomas van Klink, s2555913
 and Hylke Jellema, s2192098
 for Creative Technology M2 PPC End assignment
 
 Arduino communication based on "graphwriter" 
 by Edwin Dertien
 - lines 52-60, 144-151, 153-187
 
 Assets:
 - logo.png -- own work by Thomas van Klink
 - background-texture.jpg from Depositphotos -- https://depositphotos.com/nl/vector-images/seamless-pattern.html?qview=23759519
 - soundcreate-brand-new-start.mp3 from SoundCrate -- https://sfx.productioncrate.com/royalty-free-music/soundscrate-brand-new-start
 - foot-left.png from PNGEGG -- https://www.pngegg.com/nl/png-zkizs
 - foot-right.png - mirrored foot-left.png
 - All icons from FontAwesome
 */

//Libaries
import processing.serial.*;
import processing.sound.*;
import gifAnimation.*;

//Colors
color arduino = color(0, 129, 132);
color pressed = color(0, 53, 54);

//Settings
boolean music;
boolean sound;
float volume = 0.5;
int screen = 1;

//Global values
boolean mouseWasPressed;

//Objects
Menu main;
Test test;
Game game;
Over gameOver;

//Gifs, sound and images
Gif crab;

//Passed arduino values
int touchL = 0;
int touchR = 0;

//Variables for Arduino operations
String buff = "";
char header[] = {'L', 'R'};
int value[] = new int[2];
int diffValue[] = new int[2];
int NEWLINE = 10;
int n;
int b;
Serial port;


void setup() {
  //Sketch settings
  size(1920,1080);
  //fullScreen();
  rectMode(CENTER);
  ellipseMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);

  main = new Menu(width/2, height/2-50, 1);
  game = new Game(width/2, height/2);
  test = new Test(width/2, height/2);
  gameOver = new Over(width/2, height/2);

  load(); //Run load method to load several elements
  connect(); //Run connect method to connect the Arduino

  crab = new Gif(this, "crab.gif");
  crab.play();
}

void draw() {
  background(255);

  switch(screen) {
    //Front end
  case 1: //Main menu
    main.display();
    port.write('L'); //Indicator light green to off
    port.write('O'); //Inidcator light yellow to on
    break;
  case 2: //Game screen
    game.display();
    port.write('H'); //Indicator light green to on
    port.write('F'); //Indicator light yellow to off
    break;
  case 3: //Test screen
    test.display(); 
    port.write('H'); //Indicator light green to on
    port.write('F'); //Indicator light yellow to off
    break;
  case 4: //Game over screen
    gameOver.display();
    port.write('L'); //Indicator light green to off
    port.write('O'); //Indicator light yellow to on
    break;
  }

  //Back end
  read();
}

void mouseMoved() { //Handles hover updates for buttons
  main.update(mouseX, mouseY);
  test.update(mouseX, mouseY);
}

void mousePressed(){ //Handles click updates for buttons
  mouseWasPressed=true;
  main.clicked();
  test.clicked();
}

void load() { //Loads several elements of the program
  String[] settings = loadStrings("settings.txt"); //Loading settings from a text file.
  music = boolean(settings[0]);
  sound = boolean(settings[1]);
  volume = float(settings[2]);
  
  main.load();
  game.load();
  test.load();
  gameOver.load();
}

void saveSetting(){ //Saves setting of the program
 String settings[] = new String[3]; 
  settings[0] = str(music);
  settings[1] = str(sound);
  settings[2] = str(volume);
  saveStrings("settings.txt", settings); //Saving settings to a text file.
}

void connect() { //Connecting Arduino via serial
  println("Available serial ports:");
  for (int i = 0; i<Serial.list ().length; i++) { 
    print("[" + i + "] ");
    println(Serial.list()[i]);
  }
   port = new Serial(this, Serial.list()[0], 9600);
}

void read() {
  //Arduino controller
   while (port.available() > 0) {
   serialEvent(port.read()); // read data
   }
   touchL = value[0]; //Touch value of capacitive sensor left, when pressed it becomes 1
   touchR = value[1]; //Touch value of capacitive sensor right, when pressed it becomes 1
   }
   
   //Catch and parse serial data from Arduino
   void serialEvent(int serial) 
   { 
   try {    // try-catch because of transmission errors
   if (serial != NEWLINE) { 
   buff += char(serial);
   } else {
   // The first character tells us which axis this value is for
   char c = buff.charAt(0);
   // Remove it from the string
   buff = buff.substring(1);
   // Discard the carriage return at the end of the buffer
   buff = buff.substring(0, buff.length()-1);
   // Parse the String into an integer
   for (int z=0; z<2; z++) {
   if (c == header[z]) {
   value[z] = Integer.parseInt(buff);
   }
   }
   buff = ""; // Clear the value of "buff"
   }
   }
   catch(Exception e) {
   println("no valid data");
   } 
}
