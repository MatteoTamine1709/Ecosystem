/*
    println("Rows " + ROWS, "Cols " + COLS);
 for (int i = 0; i < NB_SOURCE; i++) {
 water_sources[i] = new PVector();
 water_sources[i].x = (int) (random(width) / CELL_SIZE);
 water_sources[i].y = (int) (random(height) / CELL_SIZE);
 map[(int) water_sources[i].x][(int) water_sources[i].y].cell_type = 0; 
 }
 float xoff = 0;
 float yoff = 0;
 float noise_val = 1;
 for (int n = 0; n < NB_SOURCE; n++) {
 for (int i = (int) water_sources[n].x; i < COLS && noise_val >= 0.2; i++) {
 for (int j = (int) water_sources[n].y; j < ROWS && noise_val >= 0.2; j++) {
 int val = map[i][j].cell_type;
 noise_val = noise(xoff, yoff);
 if (noise_val < 0.6) {
 val = 2;
 }
 map[i][j].cell_type = val;
 xoff += 0.01;
 }
 yoff += 0.01;
 }
 }
 for (int i = 0; i < NB_SOURCE; i++) {
 map[(int) water_sources[i].x][(int) water_sources[i].y].cell_type = 0; 
 }*/
