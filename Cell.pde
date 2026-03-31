class Cell {
  // Force attributes
  PVector pos;
  PVector vel;
  PVector acc;

  // Cell attributes
  float mass;
  int radius;
  color c;

  Cell(float x, float y, float mass, color c) {
    this.pos = new PVector(x, y);
    this.vel = new PVector();
    this.acc = new PVector();

    this.mass = mass;
    this.radius = int(mass) * 2;
    this.c = c;
  }

  void applyForce(PVector force) {
    force.div(mass);
    this.vel.add(force);
  }

  void update() {
    this.pos.add(this.vel);
    this.vel.add(this.acc);
    this.acc.mult(0);
  }

  void show() {
    fill(this.c);
    noStroke();
    circle(this.pos.x, this.pos.y, this.radius * 2);
  }

  void checkEdges() {
    if (this.pos.x > width + this.radius) {
      this.pos.x = -this.radius;
    } else if (this.pos.x < -this.radius) {
      this.pos.x = width + this.radius;
    } else if (this.pos.y > height + this.radius) {
      this.pos.y = -this.radius;
    } else if (this.pos.y < -this.radius) {
      this.pos.y = height + this.radius;
    }
  }
  
  // return la distance entre la cell et une autre cellule dans l'espace
  float trackDistance(Cell otherCell) {
    return dist(this.pos.x, this.pos.y, otherCell.pos.x, otherCell.pos.y);
  }
}
