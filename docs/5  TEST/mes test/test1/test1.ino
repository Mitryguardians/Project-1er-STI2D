#include <SPI.h>
#include "epd2in9b.h"
#include "imagedata.h"
#include "epdpaint.h"
#include "fonts.h"

#define COLORED     0
#define UNCOLORED   1

Epd epd;

unsigned char image[1024];
Paint paint(image, 128, 16);



bool starte = false;
int timer = 0;

int PintCapteurRecepteurLot1 = 2;
int PintCapteurRecepteurLot2 = 3;

void setup() {
  Serial.begin(9600);
  if (epd.Init() != 0) {
    Serial.print("e-Paper init failed");
    return;
  }
  pinMode(PintCapteurRecepteurLot1, INPUT);
  pinMode(PintCapteurRecepteurLot2, INPUT);

}

void loop() {
  timer += 1;
  Serial.println(timer);
  if (starte == false) {
    epd.ClearFrame();
    Text("Tramway", &Font16, UNCOLORED, COLORED, 24, 2, 0, 32);
    Text("1er STI2D1", &Font12, COLORED, UNCOLORED, 28, 2, 0, 64);

    if (timer == 20) {
      starte = true;
      timer = 0;
    }
  } else {
    epd.ClearFrame();
    Text("Gare", &Font16, UNCOLORED, COLORED, 41, 2, 0, 32);
    Text("Pont pritze", &Font16, UNCOLORED, COLORED, 3, 2, 0, 64);
  }
  epd.DisplayFrame();

  /* Deep sleep */
  epd.Sleep();


  //lire capteur
  cptRead1 = digitalRead(PintCapteurRecepteurLot1);
  cptRead2 = digitalRead(PintCapteurRecepteurLot2);

}

void Text(const char* texte, sFONT* font, uint8_t color, uint8_t colorbis, int x, int y, int xbis, int ybis) {
  paint.Clear(color);
  paint.DrawStringAt(x, y, texte, font, colorbis);
  epd.SetPartialWindowBlack(paint.GetImage(), xbis, ybis, paint.GetWidth(), paint.GetHeight());
}
