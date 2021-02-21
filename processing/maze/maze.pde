Grid grid;
ArrayList<ScreenCell> cells;
int state = 0;
int cellSize = 100;

int playerCell;
int playerSize = cellSize * 2;

void setup() {
  //size(530, 530);
  fullScreen();
  
  int rowNb = (height - 20) / cellSize;
  int colNb = (width - 20) / cellSize;
  grid = new Grid(rowNb, colNb);
  
  //BinaryTree walker = new BinaryTree();
  Sidewinder walker = new Sidewinder();
  walker.walk(grid);
  
  fill(255, 123, 245);
  
  cells = new ArrayList(grid.size());
  for(int i=0 ; i < grid.size() ; i++) {
    Cell cell = grid.getCells().get(i);
    ScreenCell drawnCell = new ScreenCell(cell, cellSize);
    cells.add(drawnCell);
  }
  
  playerCell = (int) random(cells.size());
}

void drawPlayer() {
  ScreenCell cell = cells.get(playerCell);
  int x = cell.getXCenter();
  int y = cell.getYCenter();
  
  if (playerSize > (cellSize / 4)) {
    playerSize = playerSize - 2;
  }
  
  fill(0, 255, 0);
  noStroke();
  ellipse(x, y, playerSize, playerSize);
}

void drawMaze() {
  
  // shift everything by 10 to not draw on the sides
  translate(10, 10);
  
  stroke(0);
  strokeWeight(2);
  //draw north outer wall of maze
  line(0, 0, cellSize * grid.colNumber(), 0);
  //draw west outer wall of maze
  line(0, 0, 0, cellSize * grid.rowNumber());
  
  //draw each room
  for(int i=0 ; i < cells.size() ; i++) {
    cells.get(i).draw();
  }
}

void blink() {
  if (state == 0) {
    stroke(255, 0, 0);
    state = 1;
  } else if (state == 1) {
    stroke(0, 255, 0);
    state = 2;
  } else {
    stroke(0, 0, 255);
    state = 0;
  }
}

void draw() {
  //clear background
  background(255);
  stroke(0, 0, 0);
  
  //blink();
  
  background(255, 0, 0);
  drawMaze();
  drawPlayer();
}
