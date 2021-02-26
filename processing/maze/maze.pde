Grid grid;
ArrayList<ScreenCell> cells;
int state = 0;
int cellSize = 64;

Cell playerCell;
float playerX, playerY;
float playerAngle;
float playerDeltaX, playerDeltaY;
int playerSize = cellSize * 2;

void setup() {
  size(530, 530);
  //fullScreen();
  
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
  
  int playerCellX = (int) random(grid.colNumber());
  int playerCellY = (int) random(grid.rowNumber());
  
  playerCell = grid.getCell(playerCellX, playerCellY);
  playerX = playerCell.getCol() * cellSize + (cellSize / 2);
  playerY = playerCell.getRow() * cellSize + (cellSize / 2);
}

void drawRay() {
  int r, mapX, mapY, dof;
  float rayX, rayY, rayAngle, xOffset, yOffset;
  
  rayAngle = playerAngle;
  rayX = 0;
  rayY = 0;
  xOffset = 0;
  yOffset = 0;
  boolean up = false;
  boolean down = false;
  
  for (r = 0; r < 1 ; r++) {
    dof = 0;
    up = false;
    down = false;
    float aTan = -1 / tan(rayAngle);
    
    // looking for rayX and rayY -> coordinates of the point where the ray hits an horizontal line
    
    // looking up
    if (rayAngle > PI) {
      println("looking up");
      up = true;
      down = false;
      
      rayY = ((playerY / cellSize) * cellSize ) - 0.0001;
      rayX = (playerY - rayY) * aTan + playerX;
      yOffset = -cellSize;
      xOffset = -yOffset * aTan;
    }
  
    // looking down
    if (rayAngle < PI) {
      println("looking down");
      up = false;
      down = true;
      
      rayY = ((playerY / cellSize) * cellSize ) + cellSize;
      rayX = (playerY - rayY) * aTan + playerX;
      yOffset = cellSize;
      xOffset = -yOffset * aTan;
    }
    
    // looking right or left
    if (rayAngle == 0 || rayAngle == PI) {
      println("looking sides");
      up = false;
      down = false;
      rayX = playerX;
      rayY = playerY;
      dof = grid.rowNumber();
    }
    
    while (dof < grid.rowNumber()) {
      mapX = (int) rayX / cellSize;
      mapY = (int) rayY / cellSize;
      
      println("mapx " + mapX + " - mapY " + mapY);

      boolean hitWall = false;
      
      // check that the cell pos is legit and if there is a wall
      if (mapX >= 0 && mapX < grid.colNumber() && mapY >= 0 && mapY < grid.rowNumber()) {
        Cell cell = grid.getCell(mapY, mapX);
        if (up) {
          hitWall = !cell.isLinked(cell.getSouth());
          if (hitWall) {
            // adjust rayY to cell south wall Y
            rayY = cell.getRow() * cellSize + cellSize;
          }
        } else if (down) {
          hitWall = !cell.isLinked(cell.getNorth());
          if (hitWall) {
            // adjust rayY to cell south wall Y
            rayY = cell.getRow() * cellSize;
          }
        }
      }
      
      if (hitWall) {
        dof = grid.rowNumber();
      } else {
        // no wall, move to the next cell
        rayX = rayX + xOffset;
        rayY = rayY + yOffset;
        dof = dof + 1;
      }
    }
    
    stroke(0, 0, 0);
    line(playerX, playerY, rayX, rayY);
  }
}

void drawPlayer() {
  //ScreenCell cell = cells.get(playerCell);
  //int x = playerCell.getCol() * cellSize + (cellSize / 2);
  //int y = playerCell.getRow() * cellSize + (cellSize / 2);
  
  if (playerSize > (cellSize / 4)) {
    playerSize = playerSize - 1;
  }
  
  fill(0, 255, 0);
  noStroke();
  rectMode(CENTER);
  rect(playerX, playerY, playerSize, playerSize);
  
  // draw player sight
  stroke(0, 0, 255);
  line(playerX, playerY, playerX + playerDeltaX * 5, playerY + playerDeltaY * 5);
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
  drawRay();
}

void keyPressed() {
   if (key == CODED) {
     if (keyCode == UP) {
       playerX = playerX + playerDeltaX;
       playerY = playerY + playerDeltaY;
     } else if (keyCode == DOWN) {
       playerX = playerX - playerDeltaX;
       playerY = playerY - playerDeltaY;
     } else if (keyCode == RIGHT) {
       playerAngle += 0.1;
       playerDeltaX = cos(playerAngle) * 5;
       playerDeltaY = sin(playerAngle) * 5;
       
       if (playerAngle > 2*PI) {
         playerAngle -= 2*PI;
       }
     } else if (keyCode == LEFT) {
       playerAngle -= 0.1;
       if (playerAngle < 0) {
         playerAngle += 2*PI;
       }
       playerDeltaX = cos(playerAngle) * 5;
       playerDeltaY = sin(playerAngle) * 5;
     } 
   } else {
     if (key == 'f') {
       playerSize = cellSize * 2;
     }
   }
}
