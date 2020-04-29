int CELL_SIZE = 30;
int ROWS;
int COLS;
int NB_WATER_SOURCE = (int) random(3, 6);
int NB_GRASS_SPOT = 10;
PVector[] grass_spots = new PVector[NB_GRASS_SPOT];
PVector[] water_sources = new PVector[NB_WATER_SOURCE];
Cell[][] map;
Animal[] animals = new Animal[50];

void setup() {
  size(1200, 750);
  frameRate(60);
  ROWS = height / CELL_SIZE;
  COLS = width / CELL_SIZE;
  map = new Cell[COLS][ROWS];
  map_generation();
  for (int i = 0; i < animals.length; i++) {
    PVector pos = new PVector((int) random(COLS), (int) random(ROWS));
    while (map[(int) pos.x][(int) pos.y].cell_type != WATER)
      pos = new PVector((int) random(COLS), (int) random(ROWS));
    animals[i] = new Animal(new PVector(pos.x * CELL_SIZE, pos.y * CELL_SIZE), new PVector(pos.x, pos.y));
  }
}


void draw() {
  background(0);
  for (int i = 0; i < COLS; i++) {
    for (int j = 0; j < ROWS; j++) {
      map[i][j].update();
      map[i][j].display();
    }
  }
  fill(0);
  textSize(23);
  text(frameRate, 0, 23);
  for (int i = 0; i < animals.length; i++) {
    if (animals[i].dead == false) {
      animals[i].update();
      animals[i].display();
    }
  }
  int alive = 0;
  for (int i = 0; i < animals.length; i++) {
    if (animals[i].dead == false)
      alive++;
  }
  fill(0);
  text(alive, 0, 46);
}
