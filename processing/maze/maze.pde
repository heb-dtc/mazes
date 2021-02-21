class ScreenCell {
  Cell cell;
  int cellSize;
  int red;
  int green;
  int blue;
  
  ScreenCell(Cell cell, int size) {
    this.cell = cell;
    this.cellSize = size;
    this.red = 255;
    this.green = 123;
    this.blue = 245;
  }
  
  int getCellSize() {
    return cellSize;
  }
  
  void draw() {
    // draw east wall
    if (!cell.isLinked(cell.getEast())) {
      // EAST WALL - topright to bottom pright
      line(cell.getCol() * cellSize + cellSize, cell.getRow() * cellSize,
        cell.getCol() * cellSize + cellSize, cell.getRow() * cellSize + cellSize);
    }
    
    // draw south wall
    if (!cell.isLinked(cell.getSouth())) {
      //SOUTH WALL - bottomleft to bottomright
      line(cell.getCol() * cellSize, cell.getRow() * cellSize + cellSize,
        cell.getCol() * cellSize + cellSize, cell.getRow() * cellSize + cellSize);
    }
    
    //WEST WALL - topleft to bottomleft
    //line(cell.getRow() * cellSize, cell.getCol() * cellSize, 
    //  cell.getRow() * cellSize, cell.getCol() * cellSize + cellSize);
    
    //NORTH WALL - topleft to top right
    //line(cell.getRow() * cellSize, cell.getCol() * cellSize,
    //  cell.getRow() * cellSize + cellSize, cell.getCol() * cellSize);

    // draw room floor
    //fill(255, 255, 255);
    //noStroke();
    //rect((cell.getRow() * cellSize) + 1, (cell.getCol() * cellSize) + 1, cellSize - 1, cellSize - 1);
  }
}

Grid grid;
ArrayList<ScreenCell> cells;
int state = 0;
int cellSize = 100;

void setup() {
  size(530, 530);
  //fullScreen();
  background(255, 0, 0);
  
  int rowNb = (height - 10) / cellSize;
  int colNb = (width - 10) / cellSize;
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
}

void drawMaze() {
  
  translate(10, 10);
  
  stroke(0);
  strokeWeight(4);
  //draw north outer wall of maze
  line(0, 0, cellSize * grid.rowNumber(), 0);
  //draw west outer wall of maze
  line(0, 0, 0, cellSize * grid.colNumber());
  
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
  
  stroke(0, 0, 0);
  
  //blink();
  drawMaze();
}
