class GoodCell extends Cell {
  GoodCell(float x, float y, float mass) {
    super(x, y, mass, Config.COL_GOODCELL);
  }
  
  // return si deux cellules sont en collision
  boolean fusion(GoodCell otherCell) {
    if (this.trackDistance(otherCell) < (this.radius + otherCell.radius) / 2) {
      return true;
    }

    return false;
  }
}
