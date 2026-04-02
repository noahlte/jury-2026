CellsGroup cells;

final int GROUP_SIZE = 10;
PGraphics pg;

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
}

void keyPressed( ) {
  if (key == 'r') {
    cells = new CellsGroup(GROUP_SIZE);
  } else if (key == 'b') {
    cells.spawnCell(new BadCell(random(width), height, random(10, 20)));
  } else if (key == 'g') {
    cells.spawnCell(new GoodCell(random(width), height, random(10, 20)));
  }
}
