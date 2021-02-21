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
  
  int getXCenter() {
    return cell.getCol() * cellSize + (cellSize / 2);
  }
  
  Cell getCell() {
    return cell;
  }
  
  int getYCenter() {
    return cell.getRow() * cellSize + (cellSize / 2);
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
