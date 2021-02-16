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
  
  void updateCellSize(int size) {
    if (size > this.cellSize) {
      this.red = 255;
      this.green = 123;
      this.blue = 245;
    } else {
      this.red = 134;
      this.green = 34;
      this.blue = 79;
    }
    this.cellSize = size;
  }
  
  void draw() {
    fill(red, green, blue);
    
    if (!cell.isLinked(cell.getEast())) {
      println("has east wall");
      //stroke(0, 0 , 0);
      // EAST WALL - topright to bottom pright
      line(cell.getCol() * cellSize + cellSize, cell.getRow() * cellSize,
        cell.getCol() * cellSize + cellSize, cell.getRow() * cellSize + cellSize);
    }
    
    if (!cell.isLinked(cell.getSouth())) {
      println("has south wall");
      //stroke(0, 0 , 255);
      //SOUTH WALL - bottomleft to bottomright
      line(cell.getCol() * cellSize, cell.getRow() * cellSize + cellSize,
        cell.getCol() * cellSize + cellSize, cell.getRow() * cellSize + cellSize);
    }
    
    //stroke(0, 255 ,0);
    //WEST WALL - topleft to bottomleft
    //line(cell.getRow() * cellSize, cell.getCol() * cellSize, 
    //  cell.getRow() * cellSize, cell.getCol() * cellSize + cellSize);
    
    //stroke(255, 0 ,0);
    //NORTH WALL - topleft to top right
    //line(cell.getRow() * cellSize, cell.getCol() * cellSize,
    //  cell.getRow() * cellSize + cellSize, cell.getCol() * cellSize);

    //rect(cell.getRow() * cellSize, cell.getCol() * cellSize, cellSize, cellSize);
  }
}

Grid grid;
BinaryTree walker;
ArrayList<ScreenCell> cells;
int state = 0;

void setup() {
  //size(505, 505);
  fullScreen();
  
  int cellSize = 10;
  int rowNb = height / cellSize;
  int colNb = width / cellSize;
  grid = new Grid(rowNb, colNb);

  cells = new ArrayList(grid.size());
  
  walker = new BinaryTree();
  walker.walk(grid);
  
  fill(255, 123, 245);
  
  //draw north outer wall of maze
  line(0, 0, width, 0);
  //draw west outer wall of maze
  line(0,0, 0, height);
  for(int i=0 ; i < grid.size() ; i++) {
    Cell cell = grid.getCells().get(i);
    ScreenCell drawnCell = new ScreenCell(cell, cellSize);
    cells.add(drawnCell);
    drawnCell.draw();
  }
}

void draw() {
  
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
  
  for(int i=0 ; i < cells.size() ; i++) {
    cells.get(i).draw();
  }
  
  /*int index = (int) random(grid.size());
  ScreenCell sc = cells.get(index);
  
  boolean grow = random(2) > 1 ? true : false;
  
  int newCellSize = sc.getCellSize() - (grow ? 1 : -1);
  sc.updateCellSize(newCellSize);
  sc.draw();*/
}
