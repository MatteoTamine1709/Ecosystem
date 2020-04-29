class Bush extends Vegetable {
  Bush(PVector pos_, float food_val_) {
     super(pos_, food_val_);
  }
  
  Bush(PVector pos_, float food_val_, float growth_rate_) {
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
      strokeWeight(3);
    }
    fill(161, 255, 74, this.growth_level * 255);
    rect(this.pos.x + 5, this.pos.y + 5, CELL_SIZE - 10, CELL_SIZE - 10);
  }
  
  
}
