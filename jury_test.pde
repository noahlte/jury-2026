CellsGroup cells;

final int GROUP_SIZE = 0;

void settings() {
  size(Config.SCREEN_WIDTH, Config.SCREEN_HEIGHT);
}

void setup() {
  cells = new CellsGroup(GROUP_SIZE);
}

void draw() {
  background(Config.COL_BACKGROUND);

  cells.drawMetaballs();
  cells.update();

  if (Config.DEBUG) {
    if (mousePressed) {
      GoodCell newCell = new GoodCell(mouseX, mouseY, random(10, 20));
      newCell.applyForce(new PVector(random(0, 2), random(0, 2)).mult(5));
      cells.addGoodCell(newCell);
    }
  }
}

void keyPressed( ){
  if (key == 'r') {
    cells = new CellsGroup(GROUP_SIZE);
  } else if (key == ' ') {
    cells.spawnCell(random(10, 20));
  }
}
