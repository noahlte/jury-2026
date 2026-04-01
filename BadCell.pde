class BadCell extends Cell {
  BadCell(float x, float y, float mass) {
    super(x, y, mass, Config.COL_BADCELL);
  }
  
  boolean split(GoodCell otherCell) {
    if (trackDistance(otherCell) < (radius + otherCell.radius) / 2) {
      return true;
    }
    
    return false;
  }
}
