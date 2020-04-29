int CELL_NONE = 0;
int CELL_GRASS = 1;
int CELL_WATER = 2;

class Cell {
  PVector pos;
  PVector size = new PVector(CELL_SIZE, CELL_SIZE);
  int cell_type = CELL_NONE;
  Animal animal = null;
  Vegetable vegetable = null;

  Cell(PVector pos_, int cell_type_) {
    this.pos = pos_;
    this.cell_type = cell_type_;
  }

  Cell(PVector pos_, int cell_type_, Animal animal_, int type_) {
    this.pos = pos_;
    this.cell_type = cell_type_;
    this.animal = animal_;
  }

  Cell(PVector pos_, int cell_type_, Vegetable vegetable_, int type_) {
    this.pos = pos_;
    this.cell_type = cell_type_;
    this.vegetable = vegetable_;
  }
  
  void update() {
    if (this.vegetable != null) {
      this.vegetable.update(); 
    }
  }

  void display() {
    color[] colors = {color(255), color(0, 255, 0), color(0, 0, 255)};
    stroke(0, 100);
    strokeWeight(1);
    fill(colors[this.cell_type]);
    rect(this.pos.x, this.pos.y, this.size.x, this.size.y);
    if (this.vegetable != null) {
      if (this.vegetable instanceof Tree) ((Tree) this.vegetable).display();
      else if (this.vegetable instanceof Bush) ((Bush) this.vegetable).display();
    }
  }
}
