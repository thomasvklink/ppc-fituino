/*
Fituino, an Arduino interfaced fitness game in Processing
 January 2021
 by Thomas van Klink, s2555913
 and Hylke Jellema, s2192098
 for Creative Technology M2 PPC End assignment
 
 Arduino communication based on "graphwriter" 
 by Edwin Dertien
 - lines 23-30, 36-42, 88-94, 98-122
 
 Assets:
 - logo.png -- own work by Thomas van Klink
 - background-texture.jpg from Depositphotos -- https://depositphotos.com/nl/vector-images/seamless-pattern.html?qview=23759519
 - soundcreate-brand-new-start.mp3 from SoundCrate -- https://sfx.productioncrate.com/royalty-free-music/soundscrate-brand-new-start
 */

//Libaries
import processing.serial.*;
import processing.sound.*;
import gifAnimation.*;

//Colors
color arduino = color(0, 129, 132);
color pressed = color(0, 53, 54);

//Settings
boolean music = true;
float volume = 0.5;
int screen = 1;

//Global values
boolean mouseWasPressed;

//Objects
Menu main;
Test test;
Game game;

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
  size(1920, 1080);
  rectMode(CENTER);
  ellipseMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);

  main = new Menu(width/2, height/2-50, 1);
  game = new Game(width/2, height/2);
  test = new Test(width/2, height/2);

  load();
  connect();

  crab = new Gif(this, "crab.gif");
  crab.play();
}

void draw() {
  background(255);

  switch(screen) {
    //Front end
  case 1:
    main.display();
    break;
  case 2:
    game.display();
    break;
  case 3:
    test.display();
    break;
  }

  //Back end
  read();
}

void mouseMoved() {
  main.update(mouseX, mouseY);
}

void mousePressed(){

  mouseWasPressed=true;
  main.clicked();
}
void load() {
  main.load();
  game.load();
  test.load();
}

void connect() {
  //Connecting Arduino via serial
  println("Available serial ports:");
  for (int i = 0; i<Serial.list ().length; i++) { 
    print("[" + i + "] ");
    println(Serial.list()[i]);
  }
  // port = new Serial(this, Serial.list()[0], 9600);
}

void read() {
  //Arduino controller
  /*  while (port.available() > 0) {
   serialEvent(port.read()); // read data
   }
   touchL = value[0];
   touchR = value[1];
   println(touchL, touchR);
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
   }*/
}
