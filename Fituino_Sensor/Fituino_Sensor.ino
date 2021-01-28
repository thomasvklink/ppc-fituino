/*
Fituino Sensor Interface
January 2021
by Thomas van Klink, s2555913
and Hylke Jellema, s2192098
for Creative Technology M2 PPC End assignment

Serial communication with Processing based on "graphwriter" 
by Edwin Dertien
- lines 31-32, 88-92

Capacitive sensing with the CapacitiveSensor libary
by Paul Bagder and Paul Stoffregen
- lines 25-27, 55-56
*/

//Fixed connected pins
const int LEDG = 9;
const int LEDY = 10;
const int LEDL = 12;
const int LEDR = 11;
const int SPEAKER = 8;

//Capacitive sensing
#include <CapacitiveSensor.h>                            //Include capacitive sensor libary
CapacitiveSensor SensorL = CapacitiveSensor(4, 2);       //Pin 2 is the sensor pin
CapacitiveSensor SensorR = CapacitiveSensor(4, 3);       //Pin 3 is the sensor pin

//Variables for capacitive sensing
unsigned long counter = 0;
float totalL;
float totalR;
unsigned int avgL;
unsigned int avgR;
const int TRESHOLD = 400;
boolean touchL;
boolean touchR;

//Variables for Processing communication
int data[] = {touchL,touchR};                           //Variables to send to Processing
const int DATASIZE = sizeof(data) / sizeof(int);        //Calculate size of array in a integer
char headers[] = {'L','R'};                             //Prefix for the data (headers)
int incomingByte;                                       //Variable to read incoming serial data into

void setup() {
  Serial.begin(9600);                                   //Start serial communication
  pinMode(LEDG, OUTPUT);                                //Set LED pins as outputs.
  pinMode(LEDY, OUTPUT);
  pinMode(LEDL, OUTPUT);
  pinMode(LEDR, OUTPUT);
}

void loop() {
  counter++;                                            //Increase loop counter by one
  long senseL =  SensorL.capacitiveSensor(30);          //Raw sensor data left
  long senseR =  SensorR.capacitiveSensor(30);          //Raw sensor data right
  totalL = totalL + senseL;                             //Total of sensing data left
  avgL = totalL / counter;                              //Calculate average of sensing data since program start
  totalR = totalR + senseR;                             //Total of sensing data right
  avgR = totalR / counter;                              //Calculate average of sensing data since program start

  if (senseL > avgL + TRESHOLD) {                       //If the capacitive sensor reading is higher then the average reading left + 400, it is being touched.
    touchL = true;
    touchR = false;
    tone(SPEAKER, 300);                                 //300 Hz tone out of Piezo speaker when touched
    digitalWrite(LEDL, HIGH);                           //Indicating LED left on
  } else {
    touchL = false;
    noTone(SPEAKER);                                    //Stop tone
    digitalWrite(LEDL, LOW);                            //Indicating LED left off
  }

  if (senseR > avgR + TRESHOLD) {                       //If the capacitive sensor reading is higher then the average reading right + 400, it is being touched.
    touchR = true;
    touchL = false;
    tone(SPEAKER, 300);                                 //300 Hz tone out of Piezo speaker when touched
    digitalWrite(LEDR, HIGH);                           //Indicating LED right on
  } else {
    touchR = false;
    noTone(SPEAKER);                                    //Stop tone
    digitalWrite(LEDR, LOW);                            //Indicating LED right off
  }

  //Serial communcation to Processing
  int data[] = {touchL,touchR};                          //Data array for Processing communication
  for(int z=0;z<DATASIZE;z++){                           //Print data to the serial port
    Serial.print(headers[z]);
    Serial.println(data[z]);
  }

  //Serial communication from Processing
  if (Serial.available() > 0) {
    incomingByte = Serial.read();                        // read the oldest byte in the serial buffer
    if (incomingByte == 'H') {                           // if it's a capital H, turn on the Green indicator LED (LEDG)
      digitalWrite(LEDG, HIGH);
    }                                  
    if (incomingByte == 'L') {                           // if it's an L (ASCII 76) turn off the Green indicator LED (LEDG)
      digitalWrite(LEDG, LOW);
    }
    if (incomingByte == 'O') {                           // if it's an 0 (ASCII 76) turn off the Yellow indicator LED (LEDG)
      digitalWrite(LEDY, HIGH);
    }
    if (incomingByte == 'F') {                           // if it's an F (ASCII 76) turn off the Yellow indicator LED (LEDG)
      digitalWrite(LEDY, LOW);
    }
  }
           
}
