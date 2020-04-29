void map_generation() {
  for (int i = 0; i < NB_WATER_SOURCE; i++)
    water_sources[i] = new PVector(random(COLS), random(ROWS));
  for (int i = 0; i < NB_GRASS_SPOT; i++)
    grass_spots[i] = new PVector(random(COLS), random(ROWS));
  for (int i = 0; i < COLS; i++) {
    for (int j = 0; j < ROWS; j++) {
      int val = 1;
      float best = MAX_FLOAT;
      for (int l = 0; l < NB_GRASS_SPOT; l++) {
        float d = dist(grass_spots[l].x, grass_spots[l].y, i, j);
        if (d < best) {
          best = d;
          val = 1;
        }
      }
      for (int l = 0; l < NB_WATER_SOURCE; l++) {
        float d = dist(water_sources[l].x, water_sources[l].y, i, j);
        if (d < best) {
          best = d;
          val = 2;
        }
      }
      map[i][j] = new Cell(new PVector(i * CELL_SIZE, j * CELL_SIZE), val);
    }
  }
  for (int i = 0; i < COLS; i++) {
    for (int j = 0; j < ROWS; j++) {
      if (random(1) < 0.2 && map[i][j].cell_type == CELL_GRASS) {
        map[i][j].vegetable = new Tree(new PVector(i * CELL_SIZE, j * CELL_SIZE), 0.2);
      } else if (random(1) < 0.1 && map[i][j].cell_type == CELL_GRASS) {
        map[i][j].vegetable = new Bush(new PVector(i * CELL_SIZE, j * CELL_SIZE), 0.2);
      }
    }
  }
}
