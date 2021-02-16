class BinaryTree {
  void walk(Grid grid) {
    
    for (int i=0 ; i < grid.size() ; i++) {
      Cell cell = grid.getCells().get(i);
      ArrayList<Cell> neighbors = new ArrayList();
      
      if (cell.getNorth() != null) {
        neighbors.add(cell.getNorth());
      }
      
      if (cell.getEast() != null) {
        neighbors.add(cell.getEast());
      }
      
      print("cell " + i + "->");
      if (neighbors.size() > 0) {
        int index = (int) random(neighbors.size());
       
        Cell neighbor = neighbors.get(index);
        
        if (neighbor != null) {
          println("creating link to " + index);
          cell.link(neighbor, true);
        }
      } else {
        println("no link created");
      }
    }
  }
}
