/*
Fituino, an Arduino interfaced fitness game in Processing
January 2021
by Thomas van Klink, s2555913
and Hylke Jellema, s2192098
for Creative Technology M2 PPC End assignment
 
Arduino communication based on "graphwriter" 
by Edwin Dertien
- lines 23-30, 36-42, 88-94, 98-122
*/
int touchL = 0;
int touchR = 0;

import processing.serial.*;

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
  size(1080,720);
  ellipseMode(CENTER);
  
  //Connecting Arduino via serial
   println("Available serial ports:");
   for (int i = 0; i<Serial.list ().length; i++) { 
   print("[" + i + "] ");
   println(Serial.list()[i]);
   }
   port = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  port.write('L');
  //Arduino controller
   while (port.available() > 0) {
    serialEvent(port.read()); // read data
    }
    touchL = value[0];
    touchR = value[1];
    println(touchL,touchR);
}

//Catch and parse serial data from Arduino
void serialEvent(int serial) 
{ 
  try  {    // try-catch because of transmission errors
    if(serial != NEWLINE) { 
      buff += char(serial);
    } else {
      // The first character tells us which axis this value is for
      char c = buff.charAt(0);
      // Remove it from the string
      buff = buff.substring(1);
      // Discard the carriage return at the end of the buffer
      buff = buff.substring(0, buff.length()-1);
      // Parse the String into an integer
      for(int z=0;z<2;z++) {
        if(c == header[z]) {
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