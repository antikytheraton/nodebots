import processing.serial.*;

Serial myPort;

void setup() {
  size(400, 300);
  background(0);
  smooth();
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  delay(100);
  String inBuffer = myPort.readString();
  if (inBuffer != null) {
   println(inBuffer);
  }
}