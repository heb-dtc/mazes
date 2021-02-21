class Sidewinder {
  void walk(Grid grid) {
    
    // loop over each row of the grid
    for (int i=0 ; i < grid.rowNumber() ; i++) {
      
      // get row
      ArrayList<Cell> row = grid.getRows().get(i);
      // prepare run for current row
      ArrayList<Cell> run = new ArrayList();
      
      // loop over each cell for current row
      for (int y=0 ; y < row.size() ; y++) {
        Cell cell = row.get(y);
        run.add(cell);
        
        boolean atEasternBoundary = cell.getEast() == null;
        boolean atNorthernBoundary = cell.getNorth() == null;
        boolean shouldCloseOut = atEasternBoundary || (!atNorthernBoundary && (int)random(2) == 0);
        
        if (shouldCloseOut) {
          int index = (int) random(run.size());
          Cell chosenCell = run.get(index);
          if (chosenCell.getNorth() != null) {
            chosenCell.link(chosenCell.getNorth(), true);
          }
          run.clear();
        } else {
          cell.link(cell.getEast(), true);
        }
      }
    }
  }
}
