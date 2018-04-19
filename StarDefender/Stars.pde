//Displays the game screen
class Stars{
  PImage stars;
  private int x,y;
  
  Stars(){
    stars = loadImage("tallStars.jpg");
    x = y = 0;
  }
  
  void updateLocation(){
    //image boundary solution. If ship hits wall, it stops.
    //the direction switchs back and forth between last key pressed
    //and the opposite direction
    if(x<=-1200){ //hits right wall. send ship left
      shipDirection = 0;
      print("right wall");
    }
    if (y>=1400){ //hits top wall. send ship down
      shipDirection = 1;
      print("top wall");
    }
    if (x>=1200){ //hits left wall. send ship right
      shipDirection = 2;
      print("left wall");
    }
    if (y<=-1400){ //hits bottom wall. send ship up
      shipDirection = 3;
      print("bottom wall");
    }   
    
    
    //normal updateLocation
    if (shipDirection == 0){ //ship facing left
      x += userSpeed; //background shifts right
    }
    else if (shipDirection == 1){ //ship facing down
      y -= userSpeed; //background shifts up
    }
    else if (shipDirection == 2){ //ship facing right
      x -= userSpeed; //background shifts left
    }
    else if (shipDirection == 3){ //ship facing up
      y += userSpeed; //background shifts down
    }
  }
  
  void displayStars(){
     imageMode(CENTER);
     image(stars,x,y);
     
  }
  
  
}
