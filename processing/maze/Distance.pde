class Distances {
  
  Cell root;
  HashMap<Cell, Integer> cells;
  
  Distances(Cell root) {
    this.root = root;
    this.cells = new HashMap<Cell, Integer>();
    this.cells.put(root, 0);
  }
  
  Integer get(Cell cell) {
    return cells.get(cell);
  }
  
  void setDistance(Cell cell, int distance) {
    cells.put(cell, distance);
  }
  
  Object[] getCells() {
    return cells.keySet().toArray();
  }
}
