enum CELL_POS {
  NORTH, SOUTH, EAST, WEST
}

class Cell {
  int col, row;
  HashMap<Cell, Boolean> links;
  Cell north, south, east, west; 
 
  Cell(int col, int row) {
    this.col = col;
    this.row = row;
    this.links = new HashMap();
  }
  
  int getRow() {
    return row;
  }
  
  int getCol() {
    return col;
  }
  
  void setNorth(Cell cell) {
    north = cell;
  }
  
  void setSouth(Cell cell) {
    south = cell;
  }
  
  void setEast(Cell cell) {
    east = cell;
  }
  
  void setWest(Cell cell) {
    west = cell;
  }
  
  void link(Cell cell) {
    links.put(cell, true);
    cell.link(this);
  }
  
  void unlink(Cell cell) {
    links.remove(cell);
    cell.unlink(this);
  }
  
   ArrayList<Cell> getNeighbors() {
     ArrayList<Cell> cells = new ArrayList();
     return cells;
  }
  
  Boolean contains(Cell cell) {
    return links.containsKey(cell); 
  }
}

class Grid {
  int rows, columns;
  ArrayList<ArrayList<Cell>> grid;
  
  Grid(int rows, int columns) {
    this.rows = rows;
    this.columns = columns;
    prepareGrid();
    configureCells();
  }
  
  void prepareGrid() {
    ArrayList<ArrayList<Cell>> rws = new ArrayList(rows);
    
    for(int i=0 ; i < rows ; i++) {
      ArrayList<Cell> cols = new ArrayList(columns);
      for(int y=0 ; y < columns ; y++) {
        cols.add(new Cell(i, y));
      }
      rws.add(cols);
    }
    
    this.grid = rws;
  }
  
  int size() {
    return rows * columns;
  }
  
  void configureCells() {
    for(int i=0 ; i < rows ; i++) {
      for(int y=0 ; y < columns ; y++) {
        grid.get(i).get(y).setNorth(getCell(i - 1, y));
        grid.get(i).get(y).setSouth(getCell(i + 1, y));
        grid.get(i).get(y).setEast(getCell(i, y + 1));
        grid.get(i).get(y).setWest(getCell(i, y - 1));
      }
    }
  }
  
  Cell getCell(int row, int col) {
    if (row < 0 || row >= rows) {
      return null;
    }
    
    if (col < 0 || col >= columns) {
      return null;
    }
    
    return grid.get(row).get(col);
  }
  
  ArrayList<Cell> getCells() {
    ArrayList<Cell> cells = new ArrayList(size());
    for(int i=0 ; i < rows ; i++) {
      for(int y=0 ; y < columns ; y++) {
        cells.add(getCell(i, y));
      }
    }
    return cells;
  }
}

void setup() {
  size(500, 500);
  
  int cellSize = 20;
  int cellNb = width / cellSize;
  Grid grid = new Grid(cellNb, cellNb);
  
  fill(255, 123, 245);
  for(int i=0 ; i < grid.size() ; i++) {
    println(i);
    Cell cell = grid.getCells().get(i);
    rect(cell.getRow() * cellSize, cell.getCol() * cellSize, cellSize, cellSize);
  }
}

void draw() {
}
