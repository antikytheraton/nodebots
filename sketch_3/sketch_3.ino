const int analogPin = A0;
 
void setup() {
  //Setup serial connection
  Serial.begin(9600); 
}
 
void loop() {
  //Read analog pin
  int val = analogRead(analogPin);
 
  //Write analog value to serial port:
  Serial.println(val);                                                         
}
