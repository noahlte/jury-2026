/*
Dans ce simple système d'évolution on trouve deux type de cellules : Les bonnes cellules qui quand elles se
 rejoignent fusionne pour en former une plus grande et les mauvaises cellules qui quand elle rencontre une bonne
 cellule la divise.
 */

CellsGroup cells;

final int GROUP_SIZE = 10;

void setup() {
  size(800, 1200);
  cells = new CellsGroup(GROUP_SIZE);
}

void draw() {
  background(52);

  cells.update();
}
