class Bullet{
  //bullets for userShip and Enemy Ships
  private int x, y, speedX, speedY, size;
  boolean visible;
  
  Bullet(){
    size = 5;
    visible = false; 
  }
  
  void updateLocation(){
    //bullet movement relative to space
    x = x + speedX;
    y = y + speedY;
    
    
    
    //movement relative to userShips motion
    if (shipDirection == 0){ //ship facing left
      x += userSpeed; //bullet shifts right
    }
    else if (shipDirection == 1){ //ship facing down
      y -= userSpeed; //bullet shifts up
    }
    else if (shipDirection == 2){ //ship facing right
      x -= userSpeed; //bullet shifts left
    }
    else if (shipDirection == 3){ //ship facing up
      y += userSpeed; //bulletr shifts down
    }
  }
  
  void displayBullet(){
     if (visible){
       fill(60, 230, 80);
       ellipse(x, y, size + 2, size + 2);
       
       //figure out how to blur like kailedescope project
       
       //filter(BLUR,3);
       //white in the center of bullet
       fill(255);
       ellipse(x, y, size - 2, size -2 );
     }
  }
  
}