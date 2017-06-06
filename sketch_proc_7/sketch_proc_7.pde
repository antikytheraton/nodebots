import processing.serial.*;

Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph
float inByte = 0;

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

  // set inital background:
  background(0);
  smooth();
  noStroke();
}
void draw () {
  fill(0, 5);
  rect(0, 0, width, height);
  // draw the line:
  //stroke(127, 34, 255);
  //line(xPos, height, xPos, height - inByte);
  fill(250, 20, 20);
  ellipse(xPos, height-inByte, 30, 30);

  // at the edge of the screen, go back to the beginning:
  if (xPos >= width) {
    xPos = 0;
    background(0);
    
  } else {
    // increment the horizontal position:
    xPos++;
  }
}