class Cell {
  PVector pos;
  PVector vel;
  PVector acc;

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
    vel.add(force);
  }

  void update() {
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
  }

  void show() {
    fill(c);
    noStroke();
    circle(pos.x, pos.y, radius * 2);
  }

  void checkEdges() {
    if (pos.x > width + radius) {
      pos.x = -radius;
    } else if (pos.x < -radius) {
      pos.x = width + radius;
    } else if (pos.y > height + radius) {
      pos.y = -radius;
    } else if (pos.y < -radius) {
      pos.y = height + radius;
    }
  }
  
  float trackDistance(Cell otherCell) {
    return dist(pos.x, pos.y, otherCell.pos.x, otherCell.pos.y);
  }
  
  boolean canInteract(Cell otherCell) {
    if (trackDistance(otherCell) < (radius + otherCell.radius) / 2) {
      return true;
    }
    
    return false;
  }
}
