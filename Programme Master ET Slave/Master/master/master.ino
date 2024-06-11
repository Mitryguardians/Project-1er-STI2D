#include <SoftwareSerial.h>

#define RxD 2
#define TxD 3

SoftwareSerial blueToothSerial(RxD, TxD);

// Capteurs
int Capteur_un = 5;
int Capteur_deux = 4;

int Capteur_un_state = 0;
int Capteur_deux_state = 0;

// Boutons-poussoirs
int BP1 = A0;
int BP2 = A2;
int delay1 = 512;
int delay2 = 512;

int arretMoteur = 0;

void setup() {
  Serial.begin(9600);
  // Initialisation du module Bluetooth
  blueToothSerial.begin(9600);
  pinMode(RxD, INPUT);
  pinMode(TxD, OUTPUT);
  // Initialisation des capteurs
  pinMode(Capteur_un, INPUT);
  pinMode(Capteur_deux, INPUT);

  delay(1000);
  Serial.flush();
  blueToothSerial.flush();
}

void loop() {
  // Lire l'état des capteurs
  Capteur_un_state = digitalRead(Capteur_un);
  Capteur_deux_state = digitalRead(Capteur_deux);

  // Lire les valeurs analogiques des boutons-poussoirs
  int analogValueBP1 = analogRead(BP1);
  int analogValueBP2 = analogRead(BP2);

  // Vérifier l'état des capteurs
  if (Capteur_un_state == HIGH) {
    // Aucun tram détecté
  } else {
    blueToothSerial.print("R");
    delay(100);
    arretMoteur = 1;
  }

  if (Capteur_deux_state == HIGH) {
    // Aucun tram détecté
  } else {
    blueToothSerial.print("A");
    Serial.println("Un tram (A)");
    delay(100);
    arretMoteur = 1;
  }

  // Arrêter le moteur si nécessaire
  if (arretMoteur == 1) {
    blueToothSerial.print("Z");
    arretMoteur = 0;
  }

  // Vérifier l'état des boutons-poussoirs
  if (analogValueBP1 > delay1) {
    blueToothSerial.print("O");
    Serial.println("Button pressed BP1");
  } else {
    Serial.println("Button not pressed BP1");
  }

  if (analogValueBP2 > delay2) {
    BlueToothSerial.print("F");
    Serial.println("Button pressed BP2");
  } else {
    Serial.println("Button not pressed BP2");
  }
}
