import oscP5.*;
import netP5.*;

OscP5 oscP5;

CellsGroup cells;

boolean sendCell = false;

final int GROUP_SIZE = 0;

void settings() {
  size(Config.SCREEN_WIDTH, Config.SCREEN_HEIGHT);
}

void setup() {
  cells = new CellsGroup(GROUP_SIZE);

  noCursor();
  windowTitle(Config.TITLE);
  
  oscP5 = new OscP5(this, Config.OSC_PORT);
}

void draw() {
  background(Config.COL_BACKGROUND);
  
  if (!Config.DEBUG) {
    cells.drawMetaballs();
  }
  
  cells.update();

  if (sendCell) {
    cells.spawnCell(new GoodCell(random(width), height, random(10, 20)), new PVector(random(-2, 2), random(-20, -10)));
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

void oscEvent(OscMessage theOscMessage) {
  println("### received an osc message with addrpattern "+theOscMessage.addrPattern()+" and typetag "+theOscMessage.typetag());
  if (theOscMessage.checkAddrPattern("/sendButton") == true) {
    if (theOscMessage.checkTypetag("f")) {
      sendCell = boolean(int(theOscMessage.get(0).floatValue()));
    }
  };
}
