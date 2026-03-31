class CellsGroup {
  ArrayList<GoodCell> cells;

  int size;

  CellsGroup(int size) {
    this.cells = new ArrayList<GoodCell>();

    for (int i = 0; i < size; i++) {
      GoodCell cell = new GoodCell(random(0, width), random(0, height), random(5, 10));
      cell.applyForce(new PVector(random(0, 2), random(0, 2)).mult(5));
      cells.add(cell);
    }
  }

  void update() {
    goodCellFusion();

    for (GoodCell cell : cells) {
      cell.checkEdges();
      cell.update();
      cell.show();
    }
  }

  void goodCellFusion() {
    GoodCell cellA = null;
    GoodCell cellB = null;

    for (GoodCell firstCell : cells) {
      for (GoodCell otherCell : cells) {
        if (firstCell != otherCell) {
          if (firstCell.fusion(otherCell)) {
            cellA = firstCell;
            cellB = otherCell;
            break;
          }
        }
      }
    }

    if (cellA != null && cellB != null) {
      GoodCell newCell = new GoodCell(cellA.pos.x, cellB.pos.y, cellA.mass + cellB.mass);
      PVector momentum = PVector.add(cellA.vel, cellB.vel);
      newCell.applyForce(momentum.mult(5));

      cells.add(newCell);
      cells.remove(cellA);
      cells.remove(cellB);
    }
  }
}
