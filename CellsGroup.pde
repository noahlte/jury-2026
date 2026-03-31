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

  void add(GoodCell cell) {
    this.cells.add(cell);
  }

  void update() {
    goodCellFusion();

    for (GoodCell cell : cells) {
      cell.checkEdges();
      cell.update();
      
      if (Config.DEBUG) {
        cell.show();
      }
    }
  }
  
  // S'occupe d'appliquer l'algo des metaballs dans le programme 
  // (Pour chaque pixel, calculez sa couleur en fonction des cellules existantes)
  void drawMetaballs() {
    loadPixels();

    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        int index = x + y * width;
        float sum = 0;

        for (GoodCell c : this.cells) {
          float d = dist(x, y, c.pos.x, c.pos.y);
          sum += 160 * c.radius / d;
        }

        pixels[index] = color(0, sum % 255, 0);
      }
    }

    updatePixels();
  }
  
  // Logique de Fusion
  void goodCellFusion() {
    GoodCell cellA = null;
    GoodCell cellB = null;
    
    // On détecte si deux cellule sont en collision
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
    
    // Si deux cellules sont en collision, on execute la fusion
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
