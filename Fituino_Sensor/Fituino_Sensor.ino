/*
Fituino Sensor inferface
January 2021
by Thomas van Klink, s2555913
and Hylke Jellema, s2192098
for Creative Technology M2 PPC End assignment

Serial communication with Processing based on "graphwriter" 
by Edwin Dertien
- lines 31-32, 88-92
*/

const int LEDG = 9;
const int LEDY = 10;
const int LEDL = 12;
const int LEDR = 11;
const int SPEAKER = 8;

#include <CapacitiveSensor.h>
CapacitiveSensor SensorL = CapacitiveSensor(4, 2);       //Pin 2 is the sensor pin
CapacitiveSensor SensorR = CapacitiveSensor(4, 3);       //Pin 3 is the sensor pin

unsigned long counter = 0;
float totalL;
float totalR;
unsigned int avgL;
unsigned int avgR;
boolean touchL;
boolean touchR;

int data[] = {touchL,touchR}; // fill in the number of pins to send
char headers[] = {'L','R'}; //Prefix for the pins (headers)
int incomingByte;      // a variable to read incoming serial data into

void setup() {
  Serial.begin(9600);
  pinMode(LEDG, OUTPUT);
  pinMode(LEDY, OUTPUT);
  pinMode(LEDL, OUTPUT);
  pinMode(LEDR, OUTPUT);
}

void loop() {
  counter++;
  long senseL =  SensorL.capacitiveSensor(30);
  long senseR =  SensorR.capacitiveSensor(30);
  totalL = totalL + senseL;
  avgL = totalL / counter;
  totalR = totalR + senseR;
  avgR = totalR / counter;

  if (senseL > avgL + 400) {
    touchL = true;
    touchR = false;
    tone(SPEAKER, 300);
    digitalWrite(LEDL, HIGH);
  } else {
    touchL = false;
    noTone(SPEAKER);
    digitalWrite(LEDL, LOW);
  }

  if (senseR > avgR + 400) {
    touchR = true;
    touchL = false;
    tone(SPEAKER, 300);
    digitalWrite(LEDR, HIGH);
  } else {
    touchR = false;
    noTone(SPEAKER);
    digitalWrite(LEDR, LOW);
  }

  //Test output
  Serial.print("L:");
  Serial.println(senseL);
  Serial.print("AVG L:");
  Serial.println(avgL);
  Serial.print("TOUCH L:");
  Serial.println(touchL);
  Serial.print("R:");
  Serial.println(senseR);
  Serial.print("AVG R:");
  Serial.println(avgR);
  Serial.print("TOUCH R:");
  Serial.println(touchR);
  
  int data[] = {touchL,touchR};
  for(int z=0;z<2;z++){
    Serial.print(headers[z]);
    Serial.println(data[z]);
  }

  // see if there's incoming serial data:
  if (Serial.available() > 0) {
    // read the oldest byte in the serial buffer:
    incomingByte = Serial.read();
    // if it's a capital H (ASCII 72), turn on the LED:
    if (incomingByte == 'H') {
      digitalWrite(LEDG, HIGH);
    } 
    // if it's an L (ASCII 76) turn off the LED:
    if (incomingByte == 'L') {
      digitalWrite(LEDG, LOW);
    }

    // if it's an 0 (ASCII 76) turn off the LED:
    if (incomingByte == 'O') {
      digitalWrite(LEDY, HIGH);
    }

    // if it's an F (ASCII 76) turn off the LED:
    if (incomingByte == 'F') {
      digitalWrite(LEDY, LOW);
    }
  }
  
  delay(10);
  
}
