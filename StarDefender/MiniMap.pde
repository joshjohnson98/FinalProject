class MiniMap{
  //Resides on right side of user’s screen at all times
  //Displays locations of user spaceship and the Death Star in relation to the map
  //enemy spaceships will be displayed as well
  //uses relational math to determine the mapping from the map to the mini-map
  int x, y;
  float DSx, DSy;
  float ESx, ESy;
  float USx, USy;
  
  MiniMap(){
    x = 700;
    y = 300;
    DSx = map(deathStar.x, -1200, 1200, 600, 800); 
    DSy = map(deathStar.y, -1400-offY, 1400-offY, 100, 500);
  }
  
  void displayMiniM(){
    rectMode(CENTER);
    ellipseMode(CENTER);
    fill(0);
    
    rect(x, y, 200, 600);
    
    stroke(255, 245, 25);
    strokeWeight(2);
    line(600, 100, 800, 100);
    line(600, 500, 800, 500);
    line(600, 100, 600, 500);
    line(800, 100, 800, 100);
  
    noStroke();
    fill(255, 0, 0);
    ellipse(DSx, DSy, 20, 20); //Draws the Death Star location on the mini-map
    
    //Draws each of the enemy ship locations on the mini-map
    for (int i=0; i<enemies.size();i++){
      ESx = map(enemies.get(i).x - stars.x, -1200, 1200, 600, 800);
      ESy = map(enemies.get(i).y - stars.y, -1400, 1400, 100, 500);
      
      if (ESx >= 600 && ESx <= 800){
        ellipse(ESx, ESy, 10, 10);
      }
    }
    
    USx = map(-stars.x, -1200, 1200, 600, 800);
    USy = map(-stars.y, -1400, 1400, 100, 500);
        
    fill(0, 255, 0);
    ellipse(USx, USy, 15, 15); //draws the user ship location on the mini-map
  }
  
}
