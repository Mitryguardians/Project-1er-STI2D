#include <SPI.h>
#include "epd2in9b.h"
#include "imagedata.h"
#include "epdpaint.h"

#define COLORED     0
#define UNCOLORED   1
Epd epd;
unsigned char image[1024];
Paint paint(image, 128, 18);    //width should be the multiple of 8

void TextDisplayOne() {
  paint.Clear(UNCOLORED);
  paint.SetRotate(1);
  paint.DrawStringAt(0, 0, "Projets tramways 1STI2D1", &Font12, COLORED);
  epd.SetPartialWindowBlack(paint.GetImage(), 24, 32, paint.GetWidth(), paint.GetHeight());
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  if (epd.Init() != 0) {
    Serial.print("e-Paper init failed");
    return;
  }

  /* This clears the SRAM of the e-paper display */
  epd.ClearFrame();
  
  paint.Clear(UNCOLORED);



  
  /* This displays the data from the SRAM in e-Paper module */
  epd.DisplayFrame();

  /* Deep sleep */
  epd.Sleep();
}

void loop() {
  // put your main code here, to run repeatedly:

}
