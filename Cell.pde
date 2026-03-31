class Cell {
  // Force attributes
  PVector pos;
  PVector vel;
  PVector acc;
  
  // Cell attributes
  float mass;
  int radius;
  
  Cell(float x, float y, float mass) {
    this.pos = new PVector(x, y);
    this.vel = new PVector();
    this.acc = new PVector();
    
    this.mass = mass;
    this.radius = int(mass) * 2;
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
    fill(255);
    noStroke();
    circle(this.pos.x, this.pos.y, this.radius * 2);
  }
  
  void checkEdges() {
    if (this.pos.x > width + this.radius) { this.pos.x = -this.radius; }
    else if (this.pos.x < -this.radius) { this.pos.x = width + this.radius; }
    else if (this.pos.y > height + this.radius) { this.pos.y = -this.radius; }
    else if (this.pos.y < -this.radius) { this.pos.y = height + this.radius; }
  }
  
  float trackDistance(Cell otherCell) {
    return dist(this.pos.x, this.pos.y, otherCell.pos.x, otherCell.pos.y);
  }
}
