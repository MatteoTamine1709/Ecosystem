class Vegetable {
  PVector pos;
  float food_value;
  float growth_level = 0;
  float growth_rate = random(1000) / 10000.0; //% PER SEC
  
  Vegetable(PVector pos_, float food_val_) {
    this.pos = pos_;
    this.food_value = food_val_;
  }
  
  Vegetable(PVector pos_, float food_val_, float growth_rate_) {
    this.pos = pos_;
    this.food_value = food_val_;
    this.growth_rate = growth_rate_;
  }
  
  void update() {
    if (this.growth_level < 1)
      this.growth_level += (this.growth_rate / 60);
    if (this.growth_level > 1)
      this.growth_level = 1;
  }
}
