int INH1 = 6; // borne commande moteur avance
int INH2 = 5; // borne commande moteur recul
#include <SoftwareSerial.h>

#define RxD 2
#define TxD 3

int manage_count_for_motor = 0;
SoftwareSerial blueToothSerial(RxD, TxD);

int valPOT = 0;

void setup() {
  Serial.begin(9600);
  blueToothSerial.begin(9600);
  pinMode(RxD, INPUT);
  pinMode(TxD, OUTPUT);

  pinMode(INH1, OUTPUT);
  pinMode(INH2, OUTPUT);
  digitalWrite(INH1, LOW);
  digitalWrite(INH2, LOW);
}

void loop() {
  Serial.println(manage_count_for_motor);
  char DataRecuu;
  while (blueToothSerial.available()) {
    DataRecuu = blueToothSerial.read();
    Serial.println(DataRecuu);
  }
  if (DataRecuu == 'O') {
    manage_count_for_motor = 1;
  }
  if (DataRecuu == 'F') {
    manage_count_for_motor = 2;
  }
  if (manage_count_for_motor == 1) {
    sens("GvD", DataRecuu);
  } else if (manage_count_for_motor == 2) {
    sens("DvG", DataRecuu);
  } else {
    analogWrite(INH1, 0);
    digitalWrite(INH2, LOW);

    analogWrite(INH2, 0);
    digitalWrite(INH1, LOW);
  }
}

void sens(String etat, char DataRecu) {
  if (etat == "GvD") {
    if (DataRecu == 'R') {
      for (int n = 255; n >= 0; n--) {
        analogWrite(INH1, n);
        digitalWrite(INH2, LOW);
        delay(40);
        Serial.println(n);
      }
      manage_count_for_motor = 0;
    } else {
      analogWrite(INH1, 255);
      digitalWrite(INH2, LOW);
    }
  }
  if (etat == "DvG") {
    if (DataRecu == 'A') {
      for (int n = 255; n >= 0; n--) {
        analogWrite(INH2, n);
        digitalWrite(INH1, LOW);
        delay(40);
        Serial.println(n);
      }
      manage_count_for_motor = 0;
    } else {
     analogWrite(INH2, 255);
      digitalWrite(INH1, LOW);
    }
  }
}
