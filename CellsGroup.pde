class CellsGroup {
  ArrayList<GoodCell> goodCells;
  ArrayList<BadCell> badCells;

  int size;

  CellsGroup(int size) {
    this.goodCells = new ArrayList<GoodCell>();
    this.badCells = new ArrayList<BadCell>();

    for (int i = 0; i < size; i++) {
      GoodCell cell = new GoodCell(random(0, width), random(0, height), random(10, 20));
      cell.applyForce(new PVector(random(0, 2), random(0, 2)).mult(5));
      goodCells.add(cell);
    }
  }
  
  void spawnCell(GoodCell cell) {
    PVector force = new PVector(random(-2, 2), random(-20, -10));
    cell.applyForce(force);
    goodCells.add(cell);
  }
  
  void spawnCell(BadCell cell) {
    PVector force = new PVector(random(-2, 2), random(-20, -10));
    cell.applyForce(force);
    badCells.add(cell);
  }

  void update() {
    goodCellFusion();
    //goodCellSplit(); -> Bug a corriger : Eloigner les cellules quand elle se split

    for (Cell cell : goodCells) {
      cell.checkEdges();
      cell.update();

      if (Config.DEBUG) {
        cell.show();
      }
    }
    
    for (Cell cell : badCells) {
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

        for (GoodCell c : goodCells) {
          float d = dist(x, y, c.pos.x, c.pos.y);
          sum += 160 * c.radius / d;
        }
        
        for (BadCell c : badCells) {
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

    for (GoodCell firstCell : goodCells) {
      for (GoodCell otherCell : goodCells) {
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

      goodCells.add(newCell);
      goodCells.remove(cellA);
      goodCells.remove(cellB);
    }
  }
  
  void goodCellSplit() {
    BadCell cellA = null;
    GoodCell cellB = null;

    for (BadCell firstCell : badCells) {
      for (GoodCell otherCell : goodCells) {
        if (firstCell.split(otherCell)) {
          cellA = firstCell;
          cellB = otherCell;
          break;
        }
      }
    }

    if (cellA != null && cellB != null) {
      GoodCell newCell1 = new GoodCell(cellA.pos.x, cellB.pos.y, cellB.mass / 2);
      GoodCell newCell2 = new GoodCell(cellA.pos.x, cellB.pos.y, cellB.mass / 2);
      
      PVector momentum = PVector.add(cellA.vel, cellB.vel);
      
      newCell1.applyForce(momentum.mult(5));
      newCell2.applyForce(momentum.mult(-5));

      goodCells.remove(cellB);
      badCells.remove(cellA);
      
      goodCells.add(newCell1);
      goodCells.add(newCell2);
    }
  }
}
