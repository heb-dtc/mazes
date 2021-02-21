class Cell {
  int col, row;
  HashMap<Cell, Boolean> links;
  Cell north, south, east, west; 
 
  Cell(int row, int col) {
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
  
  Cell getSouth() {
    return south;
  }
  
  Cell getNorth() {
    return north;
  }
  
  Cell getEast() {
    return east;
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
  
  void link(Cell cell, boolean bidi) {
    links.put(cell, true);
    if (bidi) {
      cell.link(this, false);
    }
  }
  
  void unlink(Cell cell) {
    links.remove(cell);
    cell.unlink(this);
  }
  
   ArrayList<Cell> getNeighbors() {
     ArrayList<Cell> cells = new ArrayList();
     if (north != null) {
       cells.add(north);
     }
     if (south != null) {
       cells.add(south);
     }
     if (east != null) {
       cells.add(east);
     }
     if (west != null) {
       cells.add(west);
     }
     return cells;
  }
  
  Boolean isLinked(Cell cell) {
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
  
  int rowNumber() {
    return rows;
  }
  
  int colNumber() {
    return columns;
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
  
  void configureCells() {
    for(int i=0 ; i < rows ; i++) {
      for(int y=0 ; y < columns ; y++) {
        Cell cell = getCell(i, y);
        
        cell.setNorth(getCell(i - 1, y));
        cell.setSouth(getCell(i + 1, y));
        cell.setWest(getCell(i, y - 1));
        cell.setEast(getCell(i, y + 1));
      }
    }
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
  
  ArrayList<ArrayList<Cell>> getRows() {
    return grid;
  }
}
