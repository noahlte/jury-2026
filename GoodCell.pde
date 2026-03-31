class GoodCell extends Cell {
  GoodCell(float x, float y, float mass) {
    super(x, y, mass);
  }

  boolean fusion(GoodCell otherCell) {
    if (this.trackDistance(otherCell) < this.radius + otherCell.radius) {
      return true;
    }

    return false;
  }
}
