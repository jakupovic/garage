#define LED 5
#define GARAGEDOOR 3

void setup() {


   // set all the other pins you're using as outputs:
   pinMode(GARAGEDOOR, OUTPUT); 
   pinMode(LED, OUTPUT);
   Serial.begin(9600);
   blink(LED, 3, 100);
   digitalWrite(GARAGEDOOR, LOW);

}

void loop() {
  if (nextByte() == 126) { // header byte ('~' character) led command
    char args[] = {0,0,0,0,0,0,0,0,0,0};
    char charIn = 0;
    byte i = 0;
    while (charIn != 126) {  // wait for header byte again
       charIn = nextByte();
       args[i] = charIn;
       i += 1;
    }
    Serial.print("here");
    if ((args[0] == 'o') && (args[1] == 'n')) {
      digitalWrite(GARAGEDOOR, HIGH);
      delay(900);
      digitalWrite(GARAGEDOOR, LOW);
      Serial.print("off  ");
    }
    else if ((args[0] == 'o') && (args[1] == 'f')) {
      digitalWrite(GARAGEDOOR, HIGH);
      delay(900);
      digitalWrite(GARAGEDOOR, LOW);
      Serial.print("on ");
    }
    delay(100);
    Serial.flush();
  }
  else if (nextByte() == 125) { // header byte pot command
    int val = analogRead(0);
    if (val < 10) {
      Serial.print(val);
      Serial.print("   ");
    }
    else if (val < 100) {
      Serial.print(val);
      Serial.print("  ");
    }
    else if (val < 1000) {
      Serial.print(val);
      Serial.print(" ");
    }
    else {
      Serial.print(val);
    }
  }
  delay(10);
  //if(Serial.available() > 0) {
    Serial.flush();
  //}
}

byte nextByte() {
    while(1) {
      if(Serial.available() > 0) {
          byte b =  Serial.read();
	  return b;
       }
    }
}
void blink(int whatPin, int howManyTimes, int milliSecs) {
    int i = 0;
    for ( i = 0; i < howManyTimes; i++) {
      digitalWrite(LED, HIGH);
      delay(milliSecs/2);
      digitalWrite(LED, LOW);
      delay(milliSecs/2);
    }
  }

