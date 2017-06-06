import processing.serial.*;

int bgcolor;
//int fgcolor;
Serial myPort;
int[] serialInArray = new int[2];
int serialCount = 0;
float xpos, ypos;
boolean firstContact = false;

int cuantos = 16000;
Pelo[] lista ;
float radio = 200;
float rx = 0;
float ry =0;

void setup() {
  size(1024, 768, P3D);

  radio = height/3.5;

  lista = new Pelo[cuantos];
  for (int i = 0; i < lista.length; i++) {
    lista[i] = new Pelo();
  }
  noiseDetail(3);
  myPort = new Serial(this, Serial.list()[0], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
}

void draw() {
  background(0);

  float rxp = (xpos-(width/2)) * 0.01;
  float ryp = (ypos-(height/2)) * 0.01;
  rx = rx*0.9 + rxp*0.1;
  ry = ry*0.9 + ryp*0.1;

  translate(width/2, height/2);
  rotateY(rx);
  rotateX(ry);
  fill(0);
  noStroke();
  sphere(radio);

  for (int i = 0; i < lista.length; i++) {
    lista[i].dibujar();
  }
}


class Pelo
{
  float z = random(-radio, radio);
  float phi = random(TWO_PI);
  float largo = random(1.15, 1.2);
  float theta = asin(z/radio);

  Pelo() { // what's wrong with a constructor here
    z = random(-radio, radio);
    phi = random(TWO_PI);
    largo = random(1.15, 1.2);
    theta = asin(z/radio);
  }

  void dibujar() {

    float off = (noise(millis() * 0.0005, sin(phi))-0.5) * 0.3;
    float offb = (noise(millis() * 0.0007, sin(z) * 0.01)-0.5) * 0.3;

    float thetaff = theta+off;
    float phff = phi+offb;
    float x = radio * cos(theta) * cos(phi);
    float y = radio * cos(theta) * sin(phi);
    float z = radio * sin(theta);

    float xo = radio * cos(thetaff) * cos(phff);
    float yo = radio * cos(thetaff) * sin(phff);
    float zo = radio * sin(thetaff);

    float xb = xo * largo;
    float yb = yo * largo;
    float zb = zo * largo;

    strokeWeight(1);
    beginShape(LINES);
    stroke(0);
    vertex(x, y, z);
    stroke(200, 150);
    vertex(xb, yb, zb);
    endShape();
  }
}

void serialEvent(Serial myPort) {
  // read the string from the serial port:
  String rawString = myPort.readString();
  println(rawString);
  //trim any unwanted empty spaces
  rawString = rawString.trim();
  try {
    //split the string into an array of 2 value (e.g. "0,127" will become ["0","127"])
    String[] values = rawString.split(",");
    // If we have 2 bytes:
    int x = int(values[0]);
    int y = int(values[1]);
    xpos = map(x, 0, 150, 0, width);
    ypos = map(y, 0, 150, 0, height);
    serialCount = 0;
  }
  catch(Exception e) {
    println("Error parsing string from Serial:");
    e.printStackTrace();
  }
}