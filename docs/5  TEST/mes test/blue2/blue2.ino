#include <SoftwareSerial.h>

SoftwareSerial blueToothSerial(2, 3); // RX / TX

void setup()
{
  blueToothSerial.begin(9600);
  Serial.begin(9600);
}

void loop()
{
  if (blueToothSerial.available()) {
    Serial.write(blueToothSerial.read());
  }

  if (Serial.available()) {
    blueToothSerial.write(Serial.read());
  }
}
