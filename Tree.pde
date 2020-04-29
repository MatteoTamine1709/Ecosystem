class Tree extends Vegetable {
  Tree(PVector pos_, float food_val_) {
     super(pos_, food_val_);
  }
  
  Tree(PVector pos_, float food_val_, float growth_rate_) {
     super(pos_, food_val_, growth_rate_);
  }
  
  boolean collision(Animal animal) {
    if (animal.pos.x == this.pos.x &&
        animal.pos.y == this.pos.y)
        return (true);
    return (false);
  }
  
  void display() {
    noStroke();
    if (this.growth_level == 1) {
      stroke(0, 100);
      strokeWeight(2);
    }
    fill(8, 105, 24, this.growth_level * 255);
    rect(this.pos.x + CELL_SIZE / 4, this.pos.y + CELL_SIZE / 4, CELL_SIZE / 2, CELL_SIZE / 2);
  }
  
}
