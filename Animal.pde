int BOTH_GENDER = 0;
int MALE = 1;
int FEMALE = 2;

int MY_NONE = -1;
int FOOD = 0;
int WATER = 1;
int REPRODUCTION = 2;

class Animal {
  PVector pos = new PVector();
  PVector pos_index = new PVector();
  PVector dest_index = new PVector(-1, -1);
  PVector dir = new PVector();
  float clock = 0;
  int speed = 3; //NB CELL PER SEC
  float hunger = 0;
  float hunger_rate = random(100) / 1000;
  float thirst = 0;
  float thirst_rate = 0.005;
  float vision_radius = 10;
  float reproductive_urge = 0;
  float reproductive_rate = 0.15;

  int current_looking = MY_NONE;
  int gender = 0;
  boolean dead = false;

  Animal(PVector pos_, PVector pos_index_) {
    this.pos = pos_;
    this.pos_index = pos_index_;
    this.current_looking = MY_NONE;
  }

  void lookFood() {
    float best_d = MAX_FLOAT;
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        if (map[i][j].vegetable != null && map[i][j].vegetable.growth_level == 1) {
          float d = dist(this.pos.x, this.pos.y, map[i][j].pos.x, map[i][j].pos.y);
          if (d < best_d) {
            best_d = d;
            this.dest_index = new PVector(i, j);
            this.current_looking = FOOD;
          }
        }
      }
    }
  }

  void lookWater() {
    float best_d = MAX_FLOAT;
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        if (map[i][j].cell_type == CELL_WATER) {
          float d = dist(this.pos.x, this.pos.y, map[i][j].pos.x, map[i][j].pos.y);
          if (d < best_d) {
            best_d = d;
            this.dest_index = new PVector(i, j);
            this.current_looking = WATER;
          }
        }
      }
    }
  }

  boolean in_need() {
    return (this.hunger > 0.2 || this.thirst > 0.2 || this.reproductive_urge > 0.2);
  }

  void get_dir() {
    if (!this.in_need() || this.current_looking == MY_NONE) {
      float rx = random(1);
      float ry = random(1);
      this.dir.x = 0;
      this.dir.y = 0;
      if (rx < 0.33)
        this.dir.x = 1;
      else if (rx < 0.66)
        this.dir.x = -1;
      else {
        this.dir.x = 0;
        if (ry < 0.5)
          this.dir.y = 1;
        else
          this.dir.y = -1;
      }
    } else {
      if (abs(this.pos_index.x - this.dest_index.x) >= abs(this.pos_index.y - this.dest_index.y)) {
        if (this.pos_index.x < this.dest_index.x)
          this.dir = new PVector(1, 0);
        else
          this.dir = new PVector(-1, 0);
      } else {
        if (this.pos_index.y < this.dest_index.y)
          this.dir = new PVector(0, 1);
        else
          this.dir = new PVector(0, -1);
      }
    }
  }

  void move_animal() {
    if (this.dir.x == 1)
      this.pos_index.x++; 
    if (this.dir.x == -1)
      this.pos_index.x--; 
    if (this.dir.y == 1)
      this.pos_index.y++; 
    if (this.dir.y == -1)
      this.pos_index.y--;
    this.pos.x += this.dir.x * CELL_SIZE;
    this.pos.y += this.dir.y * CELL_SIZE;
    this.pos_index.x = constrain(this.pos_index.x, 0, COLS - 1);
    this.pos_index.y = constrain(this.pos_index.y, 0, ROWS - 1);
    this.pos.x = constrain(this.pos.x, 0, (COLS - 1) * CELL_SIZE);
    this.pos.y = constrain(this.pos.y, 0, (ROWS - 1) * CELL_SIZE);
  }

  void move() {
    if (this.in_need() && this.hunger > this.thirst && this.hunger > this.reproductive_urge && this.hunger > 0) {
      this.lookFood();
    } else if (this.in_need() && this.thirst > this.hunger && this.thirst > this.reproductive_urge && this.thirst > 0) {
      this.lookWater();
    } else if (this.in_need()) {
      this.lookWater();
    }
    if (this.clock == 60) {
      this.get_dir();
      this.hunger += (this.hunger_rate);
      this.thirst += (this.thirst_rate);
      map[(int) this.pos_index.x][(int) this.pos_index.y].animal = null;
      this.move_animal();
      if (this.pos_index.x == this.dest_index.x && this.pos_index.y == this.dest_index.y) {
        if (this.current_looking == FOOD) {
          this.hunger -= map[(int) this.pos_index.x][(int) this.pos_index.y].vegetable.food_value;
          map[(int) this.pos_index.x][(int) this.pos_index.y].vegetable.growth_level = 0;
        }
        if (this.current_looking == WATER)
          this.thirst -= 0.3;
        this.current_looking = MY_NONE;
        this.hunger = constrain(this.hunger, 0, 1);
        this.thirst = constrain(this.thirst, 0, 1);
      }
      this.clock = 0;
      if (map[(int) (this.pos_index.x)][(int) (this.pos_index.y)].cell_type == CELL_WATER ||
        map[(int) (this.pos_index.x)][(int) (this.pos_index.y)].animal != null) {
        if (this.dir.x == 1)
          this.pos_index.x--; 
        if (this.dir.x == -1)
          this.pos_index.x++; 
        if (this.dir.y == 1)
          this.pos_index.y--; 
        if (this.dir.y == -1)
          this.pos_index.y++;
        this.pos.x += this.dir.x * CELL_SIZE * -1;
        this.pos.y += this.dir.y * CELL_SIZE * -1;
      }
      map[(int) this.pos_index.x][(int) this.pos_index.y].animal = this;
    }
    this.clock += 0.5;
  }

  void update() {
    if (this.hunger >= 1 || this.thirst >= 1)
      this.dead = true;
    //this.reproductive_urge += (this.reproductive_rate / 60);
    int i = 0;
    while (i < this.speed) {
      this.move();
      i++;
    }
  }

  void display() {
    if (this.dead == true)
      return;
    fill(143, 99, 6);
    noStroke();
    rect(this.pos.x + CELL_SIZE / 4, this.pos.y + CELL_SIZE / 4, (float) CELL_SIZE / 2, (float) CELL_SIZE / 2);
    if (this.current_looking != -1) {
      fill(0);
      rect(this.dest_index.x * CELL_SIZE + CELL_SIZE / 4, this.dest_index.y * CELL_SIZE + CELL_SIZE / 4, CELL_SIZE / 2, CELL_SIZE / 2);
      stroke(0);
      strokeWeight(3);
      float x = this.dest_index.x == -1 ? this.pos_index.x : this.dest_index.x;
      float y = this.dest_index.y == -1 ? this.pos_index.y : this.dest_index.y;
      //line(this.pos.x + CELL_SIZE / 2, this.pos.y + CELL_SIZE / 2, x * CELL_SIZE + CELL_SIZE / 2, y * CELL_SIZE + CELL_SIZE / 2);
    }
  }
}
