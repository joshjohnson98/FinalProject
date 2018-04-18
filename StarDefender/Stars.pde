//Displays the game screen
class Stars{
  PImage stars;
  private int x,y;
  
  Stars(){
    stars = loadImage("stars.jpg");
    x = y = 0;
  }
  
  void updateLocation(){
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
