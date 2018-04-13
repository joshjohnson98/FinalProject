class UserShip{
  //Use pixelated image of millenium falcon to represent the user spaceship
  //Will always remain in the center of the visible game window
  //Will rotate based on direction of movement determined by the W,A,S,D keys or up, down, left, right arrow keys
  //Will shoot “lasers” in direction of the user’s movement when the space bar is pressed
  //Will explode if hit by an asteroid, the Death Star, an enemy ship, or an enemy laser (one hit to kill)
 
  PImage shipPic; //put this in main?
  private float rot;
  
  UserShip(){
    shipPic = loadImage("millenium_falcon.png"); //put this in main?
    rot = 0;
  }
  
  void displayShip(){
    imageMode(CENTER);
    translate(width/2,height/2);
    rotate(rot);
    image(shipPic, 0, 0);
    resetMatrix();
  }
  
  void updateUserDirection(){
      if(key == 'a' || keyCode == LEFT){
        rot = 0;
      }
      else if (key == 's' || keyCode == DOWN){
        rot = 3*PI/2;
      }
      else if (key == 'd' || keyCode == RIGHT){
        rot = PI;
      }
      else if (key == 'w' || keyCode == UP){
        rot = PI/2;
      }      
  }
  
}
