/*
Dans ce simple système d'évolution on trouve deux type de cellules : Les bonnes cellules qui quand elles se
 rejoignent fusionne pour en former une plus grande et les mauvaises cellules qui quand elle rencontre une bonne
 cellule la divise.
 */

CellsGroup cells;

final int GROUP_SIZE = 10;

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
      cells.add(newCell);
    }
  }
}
