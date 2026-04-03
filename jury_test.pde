import processing.serial.*;

Serial myPort;

CellsGroup cells;


final int GROUP_SIZE = 0;

int knob;
boolean pressed;
boolean sendCell = false;


void settings() {
  size(Config.SCREEN_WIDTH, Config.SCREEN_HEIGHT);
}

void setup() {
  noCursor();
  windowTitle(Config.TITLE);

  cells = new CellsGroup(GROUP_SIZE);

  myPort = new Serial(this, Config.PORT_NAME, Config.SERIAL_PORT);
  myPort.bufferUntil('\n'); // -> Va automatiquement appelé la fonction serialEvent quand la ligne se finit
}

void draw() {
  background(Config.COL_BACKGROUND);
  
  if (!Config.DEBUG) {
    cells.drawMetaballs();
  }
  
  cells.update();

  if (sendCell) {
    cells.spawnCell(new GoodCell(random(width), height, knob), new PVector(random(-2, 2), random(-20, -10)));
    sendCell = false;
  }
}

void keyPressed( ) {
  if (key == 'r') {
    cells = new CellsGroup(GROUP_SIZE);
  } else if (key == 'b') {
    cells.spawnCell(new BadCell(random(width), height, random(10, 20)), new PVector(random(-2, 2), random(-20, -10)));
  } else if (key == 'g') {
    cells.spawnCell(new GoodCell(random(width), height, random(10, 20)), new PVector(random(-2, 2), random(-20, -10)));
  }
}

void serialEvent(Serial p) {
  String ligne = p.readStringUntil('\n');
  if (ligne != null) {
    ligne = trim(ligne);
    String[] values = split(ligne, ',');
    if (values.length == 3) {
      knob = int(values[0]);
      sendCell = boolean(int(values[1]));
    }
  }
}
