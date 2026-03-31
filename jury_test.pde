Cell cell;

void setup() {
  size(400, 600); 
  cell = new Cell(width / 2, height, 20);
}

void draw() {
  background(52);
  
  cell.update();
  cell.show();
}
