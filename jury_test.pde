/*
Dans ce simple système d'évolution on trouve deux type de cellules : Les bonnes cellules qui quand elles se 
rejoignent fusionne pour en former une plus grande et les mauvaises cellules qui quand elle rencontre une bonne
cellule la divise.
*/

ArrayList<GoodCell> cells;
ArrayList<GoodCell> cellsToRemove;

void setup() {
  size(400, 600); 
  cells = new ArrayList<GoodCell>();
  
  for (int i = 0; i < 10; i++) {
    GoodCell cell = new GoodCell(round(random(0, width)), round(random(0, height)), round(random(5, 10)));
    cell.applyForce(new PVector(random(0, 2), random(0, 2)).mult(5));
    cells.add(cell);
  }
}

void draw() {
  background(52);
  
  for (GoodCell cell : cells) {
    
    for (GoodCell otherCell : cells) {
      if (cell != otherCell) {
        if (cell.fusion(otherCell)) {
          GoodCell newCell = new GoodCell(cell.pos.x, cell.pos.y, (cell.mass + otherCell.mass) / 2);
          cells.add(newCell);
          cellsToRemove.add(cell);
          cellsToRemove.add(otherCell);
        };
      }
    }
    
    cell.checkEdges();
    cell.update();
    cell.show();
  }
}
