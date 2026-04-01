class GoodCell extends Cell {
  GoodCell(float x, float y, float mass) {
    super(x, y, mass, Config.COL_GOODCELL);
  }

  boolean fusion(GoodCell otherCell) {
    if (trackDistance(otherCell) < (radius + otherCell.radius) / 2) {
      return true;
    }
    
    return false;
  }
}
