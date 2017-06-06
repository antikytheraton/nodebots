import processing.serial.*;

Serial myPort;        // The serial port
int radius = 1;         // horizontal position of the graph
float inByte = 0;
float relleno = 0;

void setup () {
  // set the window size:
  size(1200, 600);

  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  
  noStroke();
  smooth();
}
void draw () {
  // set inital background:
  background(255);
  fill(relleno, 20, 20);
  // draw the circle:
  ellipse(width/2, height/2, inByte, inByte);
}


void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    inByte = float(inString);
    println(inByte);
    relleno = map(inByte, 0, 1023, 10, 255);
    inByte = map(inByte, 0, 1023, 0, height);
  }
}