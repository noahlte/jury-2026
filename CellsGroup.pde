class CellsGroup {
  ArrayList<GoodCell> cells;

  int size;

  CellsGroup(int size) {
    this.cells = new ArrayList<GoodCell>();

    for (int i = 0; i < size; i++) {
      GoodCell cell = new GoodCell(random(0, width), random(0, height), random(10, 20));
      cell.applyForce(new PVector(random(0, 2), random(0, 2)).mult(5));
      cells.add(cell);
    }
  }

  void addGoodCell(GoodCell cell) {
    cells.add(cell);
  }
  
  void spawnCell(float radius) {
    GoodCell newCell = new GoodCell(random(width), height, radius);
    PVector force = new PVector(random(-2, 2), -10);
    newCell.applyForce(force);
    cells.add(newCell);
  }

  void update() {
    goodCellFusion();

    for (Cell cell : cells) {
      cell.checkEdges();
      cell.update();

      if (Config.DEBUG) {
        cell.show();
      }
    }
  }

  void drawMetaballs() {
    loadPixels();

    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        int index = x + y * width;
        float sum = 0;

        for (GoodCell c : cells) {
          float d = dist(x, y, c.pos.x, c.pos.y);
          sum += 160 * c.radius / d;
        }

        pixels[index] = color(0, sum % 255, 0);
      }
    }

    updatePixels();
  }

  void goodCellFusion() {
    GoodCell cellA = null;
    GoodCell cellB = null;

    for (GoodCell firstCell : cells) {
      for (GoodCell otherCell : cells) {
        if (firstCell != otherCell && firstCell.fusion(otherCell)) {
          cellA = firstCell;
          cellB = otherCell;
          break;
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
