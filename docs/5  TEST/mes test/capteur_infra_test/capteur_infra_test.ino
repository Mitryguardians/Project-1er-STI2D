int CPT_1 = 2;
int CPT_2 = 3;

int CPT_1_STATE = 0;
int CPT_2_STATE = 0;

void setup() {
  Serial.begin(9600);
  pinMode(CPT_1, INPUT);
  pinMode(CPT_2, INPUT);
}

void loop() {
  CPT_1_STATE = digitalRead(CPT_1);
  CPT_2_STATE = digitalRead(CPT_2);


  if (CPT_1_STATE == 1)
  {
    Serial.println("Aucun tram n\'est passé (capteur 1)");
  } else {
    Serial.println("Le tram est passé (capteur 1)");
  }

  if (CPT_2_STATE == 1)
  {
    Serial.println("Aucun tram n\'est passé (capteur 2)");
  } else {
    Serial.println("Le tram est passé (capteur 2)");
  }

}
